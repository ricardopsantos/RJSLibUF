//
//  Created by Ricardo Santos on 11/07/2020.
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

//
// typealias? Why?
//
// 1 : When using RJSLib on other projects, instead of using `RJSLibNetworkClientResponse`, we can use `RJS_SimpleNetworkClientResponse` which can be more elegant to use
// 2 : When using RJSLib, we can type `RJS_` and the Xcode auto-complete feature will suggest only thing inside RJSLib
// 3 : If one day the module `SimpleNetworkClient_Protocol` changes name for something like `NotSoSimpleNetworkClient_Protocol`,
// the external apps using the alias wont need to change anything because the alias stays the same
//

import RJSLibUFBase

//
// MARK: - Regular NetWork Clients
//

public enum Result<T> {
    case success(T)
    case failure(Error)
}

public typealias RJS_BasicNetworkClient     = RJSLib.BasicNetworkClient // Handles simple GETs (`func getDataFrom:`, `func getJSONFrom:`) and images download with caching

public typealias RJS_SimpleNetworkClient    = RJSLib.SimpleNetworkClient // Handles "GET", POST, PUT, DELETE, Response decode and errors

public typealias RJS_SimpleNetworkClientProtocol        = SimpleNetworkClient_Protocol
public typealias RJS_SimpleNetworkClientRequestProtocol = SimpleNetworkClientRequest_Protocol
public typealias RJS_SimpleNetworkClientResponse        = RJSLibNetworkClientResponse     // Response entity
public typealias RJS_SimpleNetworkClientResponseType    = RJSLibNetworkClientResponseType // json, csv

//
// MARK: - FRP (Functional Reactive Programing) NetWork Clients
//

public typealias RJS_FRPSimpleNetworkClient = FRPSimpleNetworkAgent

public typealias RJS_FRPSimpleNetworkClientProtocol     = FRPSimpleNetworkAgentProtocol
public typealias RJS_FRPSimpleNetworkClientRequestModel = FRPSimpleNetworkAgentRequestModel

public struct Response<T: Decodable> {
    public let value: T
    public let response: Any
    public init(value: T, response: Any) {
        self.value = value
        self.response = response
    }
}
