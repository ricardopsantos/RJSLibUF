//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//
#if !os(macOS)
    import UIKit
#endif

public extension RJSLib {

    #if !os(macOS)
    static var version: String { return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)! }
    #endif

    struct Constants {
        private init() {}
        public static var defaultDelay: Double { 0.35 }
        public static var defaultAnimationsTime: Double { defaultDelay }
        public static var defaultDisableTimeAfterTap: Double { 1 } // Time span in which the view will be disabled after some user interaction
        private static let sharedLibConstantsId: String = "RJSLib.Constants."
        
        public static var notPredicted: String = "\(sharedLibConstantsId)notPredicted"
        public static var fail: String = "\(sharedLibConstantsId)fail"
        public static var referenceLost: String = "\(sharedLibConstantsId)referenceLost"
        public static var userInterationDisabled: String = "\(sharedLibConstantsId)userInterationDisabled"
    }
}
