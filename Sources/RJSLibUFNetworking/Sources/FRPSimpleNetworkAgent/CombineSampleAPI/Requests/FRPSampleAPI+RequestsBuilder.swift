//
//  Created by Ricardo P Santos on 2020.
//  2020 © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
import CryptoKit

public extension FRPSampleAPI {
    struct RequestsBuilder {
        private init() { }
    }
}

extension FRPSampleAPI.RequestsBuilder {
    
    static func sampleRequestJSON(_ resquestDto: FRPSampleAPI.RequestDto.Sample) -> FRPSimpleNetworkClientRequestModel {
        let /*httpBody*/ _ = [
            "publicKey": resquestDto.userID
        ]
        let /*headerValues*/ _ = [
            "userId": resquestDto.userID
        ]
        return FRPSimpleNetworkClientRequestModel(path: "v1/employees",
                            httpMethod: .get,
                            httpBody: nil,
                            headerValues: nil,
                            serverURL: "http://dummy.restapiexample.com/api",
                            responseType: .json)
    }

    static func sampleRequestCSV(_ resquestDto: FRPSampleAPI.RequestDto.Sample) -> FRPSimpleNetworkClientRequestModel {
        return FRPSimpleNetworkClientRequestModel(path: "codigos_postais.csv",
                            httpMethod: .get,
                            httpBody: nil,
                            headerValues: nil,
                            serverURL: "https://raw.githubusercontent.com/centraldedados/codigos_postais/master/data",
                            responseType: .csv)
    }
    
}
