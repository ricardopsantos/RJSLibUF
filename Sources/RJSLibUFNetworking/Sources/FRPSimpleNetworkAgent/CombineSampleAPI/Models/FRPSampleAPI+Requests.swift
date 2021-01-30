//
//  Created by Ricardo P Santos on 2020.
//  2020 © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
import Combine
import CryptoKit

extension FRPSampleAPI {
    func sampleRequestJSON(_ resquestDto: FRPSampleAPI.RequestDto.Sample) -> AnyPublisher<ResponseDto.EmployeeServiceAvailability, RJS_FRPNetworkClientAPIError> {
        let request = FRPSampleAPI.RequestsBuilder.sampleRequestJSON(resquestDto)
        return run(request: request.urlRequest!, dumpResponse: false, reponseType: request.responseFormat)
    }
    
    func sampleRequestCVS(_ resquestDto: FRPSampleAPI.RequestDto.Sample) -> AnyPublisher<[ResponseDto.PortugueseZipCode], RJS_FRPNetworkClientAPIError> {
        let request = FRPSampleAPI.RequestsBuilder.sampleRequestCSV(resquestDto)
        return run(request: request.urlRequest!, dumpResponse: false, reponseType: request.responseFormat)
    }
}
