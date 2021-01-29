//
//  Created by Ricardo Santos on 29/01/2021.
//

import Foundation
import Network
import SystemConfiguration

public extension RJSLib {
    struct NetworkUtils {
        private init() { }
    }
}

// https://www.vadimbulavin.com/network-connectivity-on-ios-with-swift/

public extension RJSLib.NetworkUtils {
    struct NetworMonitor {
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

public extension RJSLib.NetworkUtils {
     struct Reachability {
        private init() { }
        public static var isConnectedToNetwork: Bool {
            var zeroAddress              = sockaddr_in()
            zeroAddress.sin_len          = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family       = sa_family_t(AF_INET)
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }
            var flags = SCNetworkReachabilityFlags()
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
                return false
            }
            let isReachable     = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            return (isReachable && !needsConnection)
        }
    }
}
