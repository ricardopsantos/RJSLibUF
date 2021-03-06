import Foundation
import Combine
//
import RJSLibUFBase

//
// FRPSimpleNetworkAgent was inspired on
// https://www.vadimbulavin.com/modern-networking-in-swift-5-with-urlsession-combine-framework-and-codable/
// https://medium.com/swlh/better-api-management-in-swift-c2c1ad6354be
//

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

extension RJSLib {
    public class FRPSimpleNetworkAgent {
        private var session: URLSession
        public init() {
            if false {
                self.session = .shared
            } else {
                self.session = URLSession.defaultForConnectivity
            }
        }
        public init(session: URLSession) {
            self.session = session
        }
    }

}

public extension RJSLib.FRPSimpleNetworkAgent {

    // 2
    func run<T>(_ request: URLRequest,
                _ decoder: JSONDecoder,
                _ dumpResponse: Bool,
                _ reponseType: RJS_NetworkClientResponseFormat) -> AnyPublisher<RJS_Response<T>, RJS_FRPNetworkAgentAPIError> where T: Decodable {
        
        let requestDebugDump = "\(request) : \(T.self))"
        return session
            .dataTaskPublisher(for: request) // 3
            .tryMap { result -> RJS_Response<T> in
                //RJS_Logs.error("\(result.response)")
                if dumpResponse {
                    let response = String(decoding: result.data, as: UTF8.self).prefix(500)
                    RJS_Logs.debug("# Request: [\(requestDebugDump)]\n# \(response)", tag: .rjsLib)
                }
                guard let httpResponse = result.response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    if let code = (result.response as? HTTPURLResponse)?.statusCode {
                        throw RJS_FRPNetworkAgentAPIError.failedWithStatusCode(code: code)
                    } else {
                        throw RJS_FRPNetworkAgentAPIError.genericError
                    }
                }
                switch reponseType {
                case .json:
                    let value = try decoder.decodeFriendly(T.self, from: result.data) // 4
                    return RJS_Response(value: value, response: result.response)  // 5
                case .csv:
                    let data = try RJSLib.NetworkAgentUtils.parseCSV(data: result.data)
                    let value = try decoder.decodeFriendly(T.self, from: data)
                    return RJS_Response(value: value, response: result.response)  // 5
                }

        }
        .mapError { error in
            let debugMessage = """
            # Request [\(requestDebugDump)] failed
            # [\(error.localizedDescription)]
            # [\(error)]
            """
            RJS_Logs.error(debugMessage, tag: .rjsLib)
            return RJS_FRPNetworkAgentAPIError.network(description: error.localizedDescription)
        }
            .receive(on: DispatchQueue.main) // 6
            .eraseToAnyPublisher()           // 7
        
    }
    
}
