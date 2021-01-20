//
//  Created by Ricardo P Santos on 2020.
//  2020 © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation

public struct CombineSimpleNetworkAgentRequestModel {
    public let path: String
    public let httpMethod: HttpMethod
    public let httpBodyDic: [String: String]?
    public let headerValues: [String: String]?
    public let serverURL: String
}
