//
//  Created by Ricardo Santos on 21/01/2021.
//

import Foundation
//
import RJSLibUFBase

// Used on [SimpleNetworkClient] and [FRPSimpleNetworkAgent]

public extension RJSLib {
     enum HttpMethod: String {
        case get    = "GET"
        case post   = "POST"
        case put    = "PUT"
        case delete = "DELETE"
    }
}
