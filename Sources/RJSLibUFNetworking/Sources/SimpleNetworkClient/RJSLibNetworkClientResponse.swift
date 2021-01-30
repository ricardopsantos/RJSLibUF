//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
//
import RJSLibUFBase

// This wraps a successful API response and it includes the generic data as well
// The reason why we need this wrapper is that we want to pass to the client the status code and the raw response as well

public struct RJSLibNetworkClientResponse<T: Codable> {
    public let entity: T
    public let httpUrlResponse: HTTPURLResponse?
    public let data: Data?
    public let responseType: RJS_NetworkClientResponseFormat
    public init(data: Data?, httpUrlResponse: HTTPURLResponse?, responseType: RJS_NetworkClientResponseFormat) throws {
        do {
            let decoder = JSONDecoder()
            switch responseType {
            case .json: self.entity = try decoder.decodeFriendly(T.self, from: data!)
            case .csv :
                let data = try? RJSLib.NetworkAgentUtils.parseCSV(data: data!)
                self.entity = try decoder.decodeFriendly(T.self, from: data!)
            }
            self.httpUrlResponse = httpUrlResponse
            self.data            = data
            self.responseType    = responseType
        } catch {
            throw error
        }
    }
}
