//
//  Created by Ricardo P Santos on 2020.
//  2020 © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
import Combine

public class FRPSampleAPI: RJS_FRPNetworkAgentProtocol {
    public var agent = RJS_FRPSimpleNetworkClient(session: URLSession.shared)
}

// MARK: - Private

extension FRPSampleAPI {
    func run<T: Decodable>(request: URLRequest,
                           decoder: JSONDecoder = JSONDecoder(),
                           dumpResponse: Bool,
                           reponseType: RJS_NetworkClientResponseFormat) -> AnyPublisher<T, RJS_FRPNetworkAgentAPIError> {
        return agent.run(request, decoder, dumpResponse, reponseType).map(\.value).eraseToAnyPublisher()
    }
}

