//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
//
import RJSLibUFBase

public extension RJSLib {
    
    struct SimpleNetworkAgentErrorsManager {
        
        public struct APIError: Error {
            public let data: Data?
            public let httpUrlResponse: HTTPURLResponse
        }
        
        public struct Custom {
            static func with(error: Error) -> Error { return error }
        }
        
        public static func logError(response: HTTPURLResponse, request: SimpleNetworkAgentRequestProtocol) {
            let successRange = 200...299
            guard !successRange.contains(response.statusCode) else { return }
            
            func log(request: SimpleNetworkAgentRequestProtocol, status: Int, info: String="") {
                let url = request.urlRequest.url!.absoluteURL
                let message = "# Request [\(url)] failed with status code \(status)] \(info)"
                RJS_Logs.error(message, tag: .rjsLib)
                assertionFailure(message)
            }
            
            log(request: request, status: response.statusCode, info: "\(response.debugDescription)")
        }
    }
}

