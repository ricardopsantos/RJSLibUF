//
//  Created by Ricardo P Santos on 2020.
//  2020 © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
import Combine

public class FRPSampleAPI: RJS_FRPSimpleNetworkClientProtocol {
    public var agent: FRPSimpleNetworkAgent = FRPSimpleNetworkAgent(session: URLSession.shared)
    public static var serverURL = "http://dummy.restapiexample.com/api"
}

// MARK: - Private

extension FRPSampleAPI {
    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder(), _ dumpResponse: Bool = true) -> AnyPublisher<T, FRPSimpleNetworkAgentAPIError> {
        return agent.run(request, decoder, dumpResponse).map(\.value).eraseToAnyPublisher()
    }
}
