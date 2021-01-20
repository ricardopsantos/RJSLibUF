//
//  Created by Ricardo P Santos on 2020.
//  2020 © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
import CryptoKit

public struct CombineSampleAPIRequestsBuilder {
    // Sample Request
    static func sampleRequest(publicKey: Curve25519.KeyAgreement.PublicKey, userID: String) -> CombineSimpleNetworkAgentRequestModel {
        let httpBody = [
            "publicKey": "\(publicKey)",
            "userId": userID
        ]
        let headerValues = [
            "userId": userID
        ]
        
        return CombineSimpleNetworkAgentRequestModel(path: "session",
                            httpMethod: .post,
                            httpBodyDic: httpBody,
                            headerValues: headerValues,
                            serverURL: "127.1.0")
    }
}
