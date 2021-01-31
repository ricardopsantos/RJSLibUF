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
        
        //print(UIButton.RJSLibUFLayoutStyle.accept.rawValue)
        RJS_DataModelEntity.StorableKeyValue.clean()
        
        #if USE_INCLUDE_TINYCONSTRAINTS
        self.window?.rootViewController = DesignLanguageVC()
        #else
        self.window?.rootViewController = LayoutSampleVC()
        #endif

        return true
    }
}
