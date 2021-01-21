//
//  Created by Ricardo P Santos on 2020.
//  2020 © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
import Combine
import CryptoKit

extension FRPSampleAPI {
    func sampleRequest(_ resquestDto: FRPSampleAPI.RequestDto.Sample) -> AnyPublisher<ResponseDto.Availability, FRPSimpleNetworkAgentAPIError> {
        let urlRequest = FRPSampleAPI.RequestsBuilder.sampleRequest(resquestDto).urlRequest
        return run(urlRequest!)
    }
}
