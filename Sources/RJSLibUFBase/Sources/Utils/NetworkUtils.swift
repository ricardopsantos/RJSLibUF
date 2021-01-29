//
//  Created by Ricardo Santos on 29/01/2021.
//

import Foundation
import Network

public typealias RJS_NetworMonitor = RJSLib.RJPSNetworkUtils.Monitor

public extension RJSLib {
    
    struct RJPSNetworkUtils {
        private init() { }
        
        // https://www.vadimbulavin.com/network-connectivity-on-ios-with-swift/
        public struct Monitor {
            private init() {
                monitor = NWPathMonitor()
                monitor.start(queue: .global())
            }
            public static var shared = RJS_NetworMonitor()
            public var monitor: NWPathMonitor!
            
            static func eval() {
                shared.monitor.pathUpdateHandler = { path in
                    if path.status == .satisfied {
                        RJS_Logs.message("back to online", tag: .rjsLib)
                    } else {
                        RJS_Logs.message("offline mode", tag: .rjsLib)
                    }
                }
            }
        }
    }
}
