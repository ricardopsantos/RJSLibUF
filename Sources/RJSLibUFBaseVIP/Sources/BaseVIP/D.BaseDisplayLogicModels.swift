//
//  Created by Ricardo Santos on 22/01/2021.
//

import Foundation
import RJSLibUFBase

public extension RJSLib {
    struct BaseDisplayLogicModels {

        public struct Warning {
            public let title: String
            public let message: String
            public var shouldDisplay: Bool = true

            public init(title: String, message: String="") {
                self.title = title
                self.message = message
            }
        }

        public struct Error {
            public let title: String
            public let message: String
            public var shouldDisplay: Bool = true

            public init(title: String, message: String="") {
                self.title = title
                self.message = message
            }
        }

        public struct Status {
            public let title: String
            public let message: String
            public init(title: String="", message: String="") {
                self.title = title
                self.message = message
            }
        }

        public struct Loading {
            public let isLoading: Bool
            public let message: String
            public init(isLoading: Bool, message: String="") {
                self.isLoading = isLoading
                self.message = message
            }
        }
    }

}
