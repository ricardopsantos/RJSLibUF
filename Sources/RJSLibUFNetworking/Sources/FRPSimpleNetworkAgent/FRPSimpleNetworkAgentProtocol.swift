//
//  FRPSimpleNetworkAgentProtocol.swift
//  RJSLibUFNetworking
//
//  Created by Ricardo Santos on 14/02/2021.
//

import Foundation
import Combine
//
import RJSLibUFBase

//
// FRPSimpleNetworkAgent was inspired on
// https://www.vadimbulavin.com/modern-networking-in-swift-5-with-urlsession-combine-framework-and-codable/
//

public protocol FRPSimpleNetworkAgentProtocol {
    var agent: FRPSimpleNetworkAgent { get set }
}

public extension FRPSimpleNetworkAgentProtocol {
    func run<T: Decodable>(request: URLRequest,
                           decoder: JSONDecoder = JSONDecoder(),
                           dumpResponse: Bool,
                           reponseType: RJS_NetworkClientResponseFormat) -> AnyPublisher<T, RJS_FRPNetworkAgentAPIError> {
        return agent.run(request, decoder, dumpResponse, reponseType).map(\.value).eraseToAnyPublisher()
    }
}
