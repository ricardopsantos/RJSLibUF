//
//  Created by Ricardo P Santos on 2020.
//  2020 © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
//
import RJSLibUFBase

//
// FRPSimpleNetworkAgent was inspired on
// https://www.vadimbulavin.com/modern-networking-in-swift-5-with-urlsession-combine-framework-and-codable/
//

public extension RJSLib {
    struct FRPSimpleNetworkAgentRequestModel {
        public let path: String
        public let httpMethod: RJS_HttpMethod
        public let httpBody: [String: Any]?
        public let headerValues: [String: String]?
        public let serverURL: String // baseURLString
        public let responseFormat: RJS_NetworkClientResponseFormat
        
        public init(path: String,
                    httpMethod: RJS_HttpMethod,
                    httpBody: [String: String]?,
                    headerValues: [String: String]?,
                    serverURL: String,
                    responseType: RJS_NetworkClientResponseFormat) {
            self.path = path
            self.httpMethod = httpMethod
            self.httpBody = httpBody
            self.headerValues = headerValues
            self.serverURL = serverURL
            self.responseFormat = responseType
        }
    }
}

public extension RJS_FRPNetworkAgentRequestModel {
/*
    fileprivate static func toJSON<T: Codable>(some: T) -> String? {
        guard let data = try? JSONEncoder().encode(some.self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
*/
    var urlRequest: URLRequest? {
        return URLRequest.with(urlString: "\(serverURL)/\(path)",
                               httpMethod: httpMethod.rawValue,
                               httpBody: httpBody,
                               headerValues: headerValues)
    }
}
