//
//  Created by Ricardo P Santos on 2020.
//  2020 © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
import Combine
//
import RJSLibUFBase

private var cancelBag = CancelBag()

public extension RJSLib {

    static func frpSampleAPIUseCase() {
        let api: FRPSampleAPIRequestProtocol = FRPSampleAPI()
        
        let request1Dto = SampleRequest1Dto(someParam: "aaa")
        let request2Dto = SampleRequest2Dto(someParam: "aaa")
        let publisherA = api.sampleRequestCVS(request2Dto)
        let publisherB = api.sampleRequestJSON(request1Dto)

        publisherA.sink { (_) in
            //RJS_Logs.info(result)
        } receiveValue: { (response) in
            RJS_Logs.debug(response.prefix(3), tag: .rjsLib)
        }.store(in: cancelBag)
        
        publisherB.sink { (_) in
            //RJS_Logs.info(result)
        } receiveValue: { (response) in
            RJS_Logs.debug(response.data.prefix(3), tag: .rjsLib)
        }.store(in: cancelBag)
    }
}
