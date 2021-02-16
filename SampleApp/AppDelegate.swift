//
//  AppDelegate.swift
//  RJSLib.Sample
//
//  Created by Ricardo P Santos on 23/06/2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import UIKit
import SwiftUI
//
import RJSLibUFBase
import RJSLibUFNetworking
import RJSLibUFStorage
import RJSLibUFAppThemes
import RJSLibUFALayouts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        RJS_DataModelEntity.StorableKeyValue.clean()

        RJS_ColdCache.shared.printReport()

        let key = "LoginCount"
        if let loginsCount = RJS_StorableKeyValue.with(key: key) {
            RJS_Logs.info(loginsCount, tag: .rjsLib)
            if let recordValue = loginsCount.value, let loginsCount =  Int(recordValue) {
                _ = RJS_StorableKeyValue.save(key: key, value: "\(loginsCount+1)")
            }
        } else {
            _ = RJS_StorableKeyValue.save(key: key, value: "0")
        }
        
        #if USE_INCLUDE_TINYCONSTRAINTS
        self.window?.rootViewController = DesignLanguageVC()
        #else
        self.window?.rootViewController = TabBarController()
        #endif

        return true
    }
}
