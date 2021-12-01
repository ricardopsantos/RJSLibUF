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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
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
        
        self.window?.rootViewController = TabBarControllerV2().viewController

        return true
    }
}
