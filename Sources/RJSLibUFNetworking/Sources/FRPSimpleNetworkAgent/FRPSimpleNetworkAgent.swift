import Foundation
import Combine
//
import RJSLibUFBase

// https://www.vadimbulavin.com/modern-networking-in-swift-5-with-urlsession-combine-framework-and-codable/

/*
 Agent is a promise-based HTTP client. It fulfils and configures requests by passing a single URLRequest object to it.
 The agent automatically transforms JSON data into a Codable value and returns an AnyPublisher instance:

 1 - Response<T> carries both parsed value and a URLResponse instance. The latter can be used for status code validation and logging.
 2 - The run<T>() method is the single entry point for requests execution. It accepts a URLRequest instance that fully
 describes the request configuration. The decoder is optional in case custom JSON parsing is needed.
 3 - Create data task as a Combine publisher.
 4 - Parse JSON data. We have constrained T to be Decodable in the run<T>() method declaration.
 5 - Create the Response<T> object and pass it downstream. It contains the parsed value and the URL response.
 6 - Deliver values on the main thread.
 7 - Erase publisher’s type and return an instance of AnyPublisher.
 */

public protocol FRPSimpleNetworkClientProtocol {
    var agent: FRPSimpleNetworkAgent { get set }
}

public class FRPSimpleNetworkAgent {
    private init() { self.session = .shared }
    private var session: URLSession
    public init(session: URLSession) {
        self.session = session
    }
}

public extension FRPSimpleNetworkAgent {

    // 2
    func run<T>(_ request: URLRequest,
                _ decoder: JSONDecoder,
                _ dumpResponse: Bool,
                _ reponseType: RJS_NetworkClientResponseFormat) -> AnyPublisher<Response<T>, FRPSimpleNetworkClientAPIError> where T: Decodable {
        
        let requestDebugDump = "\(request) : \(T.self)"
        return session
            .dataTaskPublisher(for: request) // 3
            .tryMap { result -> Response<T> in
                guard let httpResponse = result.response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    if let code = (result.response as? HTTPURLResponse)?.statusCode {
                        throw FRPSimpleNetworkClientAPIError.failedWithStatusCode(code: code)
                    } else {
                        throw FRPSimpleNetworkClientAPIError.genericError
                    }
                }
                if dumpResponse {
                    RJS_Logs.message("request: \(requestDebugDump)\n\(String(decoding: result.data, as: UTF8.self))")
                }
                switch reponseType {
                case .json:
                    let value = try decoder.decodeFriendly(T.self, from: result.data) // 4
                    return Response(value: value, response: result.response)  // 5
                case .csv:
                    let data = try RJSLib.NetworkAgentUtils.parseCSV(data: result.data)
                    let value = try decoder.decodeFriendly(T.self, from: data)
                    return Response(value: value, response: result.response)  // 5
                }

        }
        .mapError { error in
            RJS_Logs.message("Request [\(requestDebugDump)] failed with error [\(error.localizedDescription))]")
            RJS_Logs.error("\(error)")
            return FRPSimpleNetworkClientAPIError.network(description: error.localizedDescription)
        }
            .receive(on: DispatchQueue.main) // 6
            .eraseToAnyPublisher()           // 7
        
    }
    
}
