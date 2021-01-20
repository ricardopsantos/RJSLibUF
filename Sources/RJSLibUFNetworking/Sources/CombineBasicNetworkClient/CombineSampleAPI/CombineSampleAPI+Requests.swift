//
//  Created by Ricardo P Santos on 2020.
//  2020 © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
import Combine
import CryptoKit

extension CombineSampleAPI {
    public struct ResponseDto {
        private init() { }
        
        public struct Session: Codable {
            public let publicKey: String
        }

        public struct SecureRequest: Codable {
            public let message: String
        }
    }
}

//
//Sample
//

extension CombineSampleAPI {
    func sampleRequest(publicKey: Curve25519.KeyAgreement.PublicKey, userID: String) -> AnyPublisher<ResponseDto.Session, APIError> {
        let urlRequest = CombineSampleAPIRequestsBuilder.sampleRequest(publicKey: publicKey, userID: userID).urlRequest!
        return run(urlRequest)
    }
}
