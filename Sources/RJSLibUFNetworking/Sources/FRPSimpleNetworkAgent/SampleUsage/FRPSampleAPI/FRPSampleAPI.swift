//
//  Created by Ricardo P Santos on 2020.
//  2020 © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
//
import RJSLibUFBase
import Combine

protocol FRPSampleAPIRequestProtocol {
    func sampleRequestJSON(_ resquestDto: SampleRequest1Dto) -> AnyPublisher<SampleResponse1Dto, RJS_FRPNetworkAgentAPIError>
    func sampleRequestCVS(_ resquestDto: SampleRequest2Dto) -> AnyPublisher<[SampleResponse2Dto], RJS_FRPNetworkAgentAPIError>
}

public class FRPSampleAPI: RJS_FRPNetworkAgentProtocol, FRPSampleAPIRequestProtocol {
    public var client = RJS_FRPSimpleNetworkClient(session: URLSession.defaultForConnectivity)
    //private var agent1 = RJS_FRPSimpleNetworkClient()
    //private var agent2 = RJS_FRPSimpleNetworkClient(session: URLSession.defaultForConnectivity)
    //private var agent3 = RJS_FRPSimpleNetworkClient(session: URLSession.shared)
}
