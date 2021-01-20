//
//  Created by Ricardo P Santos on 2020.
//  2020 © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
import Combine
import CryptoKit

struct ResponseDto {
    private init() { }
    public struct Session: Codable {
        let publicKey: String
    }

    public struct SecureRequest: Codable {
        let message: String
    }
}

//
//Sample
//

extension CombineSimpleWebAPI {
    func sampleRequest(publicKey: Curve25519.KeyAgreement.PublicKey, userID: String) -> AnyPublisher<ResponseDto.Session, APIError> {
        let urlRequest = RequestsBuilder.sampleRequest(publicKey: publicKey, userID: userID).urlRequest!
        return run(urlRequest)
    }
}
