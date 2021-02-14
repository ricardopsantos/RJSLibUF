//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

// swiftlint:disable no_print

import Foundation
import Combine
//
import RJSLibUFBase

public extension RJSLib {
    class SimpleNetworkAgent: SimpleNetworkClientProtocol {
        let urlSession: SimpleNetworkClientURLSessionProtocol

        public init(urlSessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default,
                    completionHandlerQueue: OperationQueue = OperationQueue.main) {
            urlSession = URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: completionHandlerQueue)
        }
        
        // Used mainly for testing purposes
        public init(urlSession: SimpleNetworkClientURLSessionProtocol) {
            self.urlSession = urlSession
        }
        
        // MARK: - ApiClient
        public func execute<T>(request: SimpleNetworkAgentRequestProtocol, completionHandler: @escaping (Result<RJS_SimpleNetworkAgentResponse<T>>) -> Void) {

            //
            // Mock data
            //
            if request.mockedData != nil {
                let mockedData = request.mockedData!.trimmingCharacters(in: .whitespacesAndNewlines)
                if mockedData.count>0 {
                    do {
                        let data: Data? = mockedData.utf8Data
                        let response = try RJS_SimpleNetworkAgentResponse<T>(data: data, httpUrlResponse: nil, responseType: request.responseType)
                        DispatchQueue.main.async {
                            RJS_Logs.debug("# Returned mocked data for [\(request.urlRequest)]", tag: .rjsLib)
                            completionHandler(.success(response))
                        }
                    } catch {
                        // Fail! Log and continue request
                        assertionFailure("Error [\(error)] returning mocked data for [\(request.urlRequest)] with data\n\n\(mockedData))")
                    }
                }
            }

            let dataTask = urlSession.dataTask(with: request.urlRequest) { (data, response, error) in

                guard let httpUrlResponse = response as? HTTPURLResponse else {
                    completionHandler(.failure(RJSLib.SimpleNetworkAgentErrorsManager.Custom.with(error: error!)))
                    return
                }
                
                let doWork = {
                    let successRange = 200...299
                    if successRange.contains(httpUrlResponse.statusCode) {
                        do {
                            let response = try RJS_SimpleNetworkAgentResponse<T>(data: data, httpUrlResponse: httpUrlResponse, responseType: request.responseType)
                            if request.debugRequest && data != nil {
                                let dataString: String = String(data: data!, encoding: .utf8) ?? ""
                                let debugMessage = """
                                # Request: \(String(describing: request.urlRequest.url?.absoluteURL))
                                # Response:\(dataString)"
                                """
                                RJS_Logs.debug(debugMessage, tag: .rjsLib)
                            }
                            completionHandler(.success(response))
                        } catch {
                            completionHandler(.failure(error))
                        }
                    } else {
                        if request.debugRequest {
                            RJSLib.SimpleNetworkAgentErrorsManager.logError(response: httpUrlResponse, request: request)
                        }
                        completionHandler(.failure(RJSLib.SimpleNetworkAgentErrorsManager.APIError(data: data, httpUrlResponse: httpUrlResponse)))
                    }
                }
                
                if request.returnOnMainTread {
                    DispatchQueue.main.async { doWork() }
                } else { doWork() }
            }
            dataTask.resume()
        }
    }
}
