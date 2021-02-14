//
//  SimpleNetworkClientRequestProtocol.swift
//  RJSLibUFNetworking
//
//  Created by Ricardo Santos on 14/02/2021.
//

import Foundation

public protocol SimpleNetworkAgentRequestProtocol {
    var urlRequest: URLRequest { get }
    var responseType: RJS_NetworkClientResponseFormat { get set }
    var debugRequest: Bool { get set }
    var returnOnMainTread: Bool { get set }
    var mockedData: String? { get }
}

public protocol SimpleNetworkClientProtocol {
    func execute<T>(request: SimpleNetworkAgentRequestProtocol, completionHandler: @escaping (_ result: Result<RJS_SimpleNetworkAgentResponse<T>>) -> Void)
}

public protocol SimpleNetworkClientURLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: SimpleNetworkClientURLSessionProtocol { }
