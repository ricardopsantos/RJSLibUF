//
//  Created by Ricardo P Santos on 2020.
//  2020 © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
//
import RJSLibUFBase

public class FRPSampleAPI: RJS_FRPNetworkAgentProtocol {
    public var agent = RJS_FRPSimpleNetworkClient(session: URLSession.defaultForConnectivity)
    
    private var agent1 = RJS_FRPSimpleNetworkClient()
    private var agent2 = RJS_FRPSimpleNetworkClient(session: URLSession.defaultForConnectivity)
    private var agent3 = RJS_FRPSimpleNetworkClient(session: URLSession.shared)
}
