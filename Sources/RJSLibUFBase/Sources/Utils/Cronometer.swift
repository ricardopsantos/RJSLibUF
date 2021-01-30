//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import UIKit

extension RJSLib {
    public struct Cronometer {
        
        /**
         * RJSCronometer.printTimeElapsedWhenRunningCode("nthPrimeNumber")
         * {
         *    log(RJSCronometer.nthPrimeNumber(10000))
         * }
         */
        @discardableResult
        public static func printTimeElapsedWhenRunningCode(_ title: String, operation: () -> Void) -> Double {
            let startTime = CFAbsoluteTimeGetCurrent()
            operation()
            let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
            Logger.info("Time elapsed for \(title): \(timeElapsed)s", tag: .rjsLib)
            return timeElapsed
        }
        
        public static func timeElapsedInSecondsWhenRunningCode(_ operation:() -> Void) -> Double {
            let startTime = CFAbsoluteTimeGetCurrent()
            operation()
            let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
            return Double(timeElapsed)
        }
        
        private static var _times: [String: CFAbsoluteTime] = [:]
        
        public static func startTimerWith(identifier: String="") {
            synced(_times) {
                _times.removeValue(forKey: identifier)
                _times[identifier] = CFAbsoluteTimeGetCurrent()
            }
        }
        
        public static func timeElapsed(identifier: String="", print: Bool) -> Double? {
            var result: Double?
            synced(_times) {
                if let time = _times[identifier] {
                    let timeElapsed = CFAbsoluteTimeGetCurrent() - time
                    if print {
                        RJS_Logs.info("Operation [\(identifier)] time : \(Double(timeElapsed))" as AnyObject, tag: .rjsLib)
                    }
                    result = Double(timeElapsed)
                }
            }
            return result ?? 0
        }

        public static func remove(identifier: String) {
            _ = synced(_times) {
                _times.removeValue(forKey: identifier)
            }
        }
        
    }
    
}
#endif
