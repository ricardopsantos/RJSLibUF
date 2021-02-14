//
//  Created by Ricardo P Santos on 2020.
//  2020 © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
import Combine
import CryptoKit

//
// MARK: - FRPSampleAPI
//
extension FRPSampleAPI {
    func sampleRequestJSON(_ resquestDto: SampleRequest1Dto) -> AnyPublisher<SampleResponse1Dto, RJS_FRPNetworkAgentAPIError> {
        let request = FRPSampleAPI.RequestsBuilder.sampleRequestJSON(resquestDto)
        return agent.run(request.urlRequest!, JSONDecoder(), false, request.responseFormat).map(\.value).eraseToAnyPublisher() // Not using extension
    }
    
    func sampleRequestCVS(_ resquestDto: SampleRequest2Dto) -> AnyPublisher<[SampleResponse2Dto], RJS_FRPNetworkAgentAPIError> {
        let request = FRPSampleAPI.RequestsBuilder.sampleRequestCSV(resquestDto)
        return run(request: request.urlRequest!, dumpResponse: false, reponseType: request.responseFormat) // Using extension
    }
}

// MARK: - FRPSampleAPI Private

private extension FRPSampleAPI {
    func run<T: Decodable>(request: URLRequest,
                           decoder: JSONDecoder = JSONDecoder(),
                           dumpResponse: Bool,
                           reponseType: RJS_NetworkClientResponseFormat) -> AnyPublisher<T, RJS_FRPNetworkAgentAPIError> {
        return agent.run(request, decoder, dumpResponse, reponseType).map(\.value).eraseToAnyPublisher()
    }
}

//
// MARK: - RequestsBuilder
//

extension FRPSampleAPI.RequestsBuilder {
    
    static func sampleRequestJSON(_ resquestDto: SampleRequest1Dto) -> RJS_FRPNetworkAgentRequestModel {
        let /*httpBody*/ _ = [
            "publicKey": resquestDto.someParam
        ]
        let /*headerValues*/ _ = [
            "userId": resquestDto.someParam
        ]
        return RJS_FRPNetworkAgentRequestModel(path: "v1/employees",
                            httpMethod: .get,
                            httpBody: nil,
                            headerValues: nil,
                            serverURL: "http://dummy.restapiexample.com/api",
                            responseType: .json)
    }

    static func sampleRequestCSV(_ resquestDto: SampleRequest2Dto) -> RJS_FRPNetworkAgentRequestModel {
        return RJS_FRPNetworkAgentRequestModel(path: "codigos_postais.csv",
                            httpMethod: .get,
                            httpBody: nil,
                            headerValues: nil,
                            serverURL: "https://raw.githubusercontent.com/centraldedados/codigos_postais/master/data",
                            responseType: .csv)
    }
    
}
