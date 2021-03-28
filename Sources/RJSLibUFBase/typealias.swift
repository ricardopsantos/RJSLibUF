//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

//
// typealias? Why?
//
// 1 : When using RJSLib on other projects, instead of using `RJSLib.AppAndDeviceInfo`, we can use `RJS_DeviceInfo` which can be more elegant and short to use
// 2 : When using RJSLib, we can type `RJS_` and the Xcode auto-complete feature will suggest only thing inside RJSLib
// 3 : If one day the module `RJSLib.Designables.SearchBar` changes place for something like `RJSLib.UIComponents.SearchBar`,
// the external apps using the alias wont need to change anything because the alias stays the same
//

// MARK: - Utils

public typealias RJS_AppInfo          = RJSLib.AppAndDeviceInfo   // Utilities for apps and device info. Things like `isSimulator`, `hasNotch`, etc
public typealias RJS_DeviceInfo       = RJSLib.AppAndDeviceInfo   // Same as RJS_AppInfo
public typealias RJS_Constants        = RJSLib.Constants          // Util constants like `defaultDelay`, etc
public typealias RJS_Logs             = RJSLib.Logger             // Simple logger. Handles verbose, warning and errors
public typealias RJS_Utils            = RJSLib.Utils              // Utilities like `onDebug`, `onRelease`, `executeOnce`, etc
public typealias RJS_Convert          = RJSLib.Convert            // Types conversion utilities. Things like `isBase64`, `toB64String`, `toBinary`, etc

// MARK: - Utils SwiftUI

#if !os(macOS)
public typealias RJS_ViewControllerRepresentable = RJSLib.ViewControllerRepresentable
public typealias RJS_ViewRepresentable           = RJSLib.ViewRepresentable2
#endif

// MARK: - Networking

public typealias RJS_NetworMonitor = RJSLib.NetworkUtils.NetworMonitor
public typealias RJS_Reachability  = RJSLib.NetworkUtils.Reachability

// MARK: - Cool Stuff

public typealias RJS_OperationQueueManager = RJSLib.OperationQueues.OperationQueueManager
public typealias RJS_OperationBase         = RJSLibOperationBase
public typealias RJS_SynchronizedArray     = SynchronizedArray
public typealias RJS_GenericStore          = RJSLib.GenericStore

#if !os(macOS)
public typealias RJS_Cronometer        = RJSLib.Cronometer         // Utilities class for measure operations time
#endif

// MARK: - Property Wrappers

public typealias RJS_Resolver = RJSLib.Container // Dependency Injection
public typealias RJS_Inject   = RJSLib.Inject    // Dependency Injection

public typealias RJS_Delegated      = RJSLib.Delegated_V2
public typealias RJS_Defaults       = RJSLib.UserDefaults
public typealias RJS_Expirable      = RJSLib.Expirable
public typealias RJS_CachedFunction = RJSLib.CachedFunction

// MARK: - Value types

public typealias RJS_ViewState     = RJSLib.HashableModelState
public typealias RJS_ModelState    = RJSLib.HashableModelState
public typealias RJS_Result        = RJSLib.Result
public typealias RJS_Response      = RJSLib.Response
public typealias RJS_CacheStrategy = RJSLib.CacheStrategy
public typealias RJS_ColorScheme   = RJSLib.ColorScheme
