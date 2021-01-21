//
//  Created by Ricardo P Santos on 2020.
//  2020 © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation

public struct FRPSimpleNetworkClientRequestModel {
    public let path: String
    public let httpMethod: RJS_HttpMethod
    public let httpBody: [String: String]?
    public let headerValues: [String: String]?
    public let serverURL: String
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

public extension FRPSimpleNetworkClientRequestModel {

    fileprivate static func toJSON<T: Codable>(some: T) -> String? {
        guard let data = try? JSONEncoder().encode(some.self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    var urlRequest: URLRequest? {
        guard let theURL = URL(string: "\(serverURL)/\(path)") else { return nil }
        var request = URLRequest(url: theURL)
        request.httpMethod = httpMethod.rawValue.uppercased()
        
        if let httpBody = httpBody {
            request.httpBody = try? JSONSerialization.data(withJSONObject: httpBody, options: .prettyPrinted)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }
        
        headerValues?.forEach({ (kv) in
            request.addValue(kv.value, forHTTPHeaderField: kv.key)
        })
        
        return request
    }
}
