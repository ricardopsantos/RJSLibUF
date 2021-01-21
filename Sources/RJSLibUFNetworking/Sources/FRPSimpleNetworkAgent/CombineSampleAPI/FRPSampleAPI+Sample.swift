//
//  Created by Ricardo P Santos on 2020.
//  2020 © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
import Combine
//
import RJSLibUFBase

private var cancelBag = CancelBag()

// swiftlint:disable multiple_closures_with_trailing_closure no_space_in_method_call

public extension FRPSampleAPI {

    static func doTest() {
        let api: FRPSampleAPI = FRPSampleAPI()
        
        let requestDto = FRPSampleAPI.RequestDto.Sample(userID: "")
        let publisherA = api.sampleRequestCVS(requestDto)
        let publisherB = api.sampleRequestJSON(requestDto)

        publisherA.sink { (_) in
            //RJS_Logs.message(result)
        } receiveValue: { (response) in
            RJS_Logs.message(response)
        }.store(in: cancelBag)
        
        publisherB.sink { (_) in
            //RJS_Logs.message(result)
        } receiveValue: { (response) in
            RJS_Logs.message(response.data)
        }.store(in: cancelBag)
    }
}
