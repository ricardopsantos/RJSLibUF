//
//  Created by Ricardo P Santos on 2020.
//  2020 © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
import Combine

// swiftlint:disable nesting

public extension FRPSampleAPI {
     struct RequestDto {
        private init() { }
    }
}

extension FRPSampleAPI.RequestDto {
    struct Sample {
        let userID: String
    }
}
