//
//  Created by Ricardo P Santos on 2020.
//  2020 © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
import CryptoKit

public extension FRPSampleAPI {
    struct RequestsBuilder {
        private init() { }
    }
}

extension FRPSampleAPI.RequestsBuilder {
    
    static func sampleRequest(_ resquestDto: FRPSampleAPI.RequestDto.Sample) -> FRPSimpleNetworkAgentRequestModel {
        let httpBody = [
            "publicKey": resquestDto.userID
        ]
        let headerValues = [
            "userId": resquestDto.userID
        ]
        return FRPSimpleNetworkAgentRequestModel(path: "v1/employees",
                            httpMethod: .get,
                            httpBody: httpBody,
                            headerValues: headerValues,
                            serverURL: FRPSampleAPI.serverURL)
    }
    
}
