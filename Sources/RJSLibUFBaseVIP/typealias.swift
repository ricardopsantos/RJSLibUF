//
//  Created by Ricardo Santos on 21/01/2021.
//

import RJSLibUFBase
public typealias V = AppView
open class AppView { private init() {} }

public typealias VC = ViewController
public class ViewController { private init() {} }

public typealias VM = ViewModel
public struct ViewModel { private init() {} }

public typealias P = Presenter
public struct Presenter { private init() {} }

public typealias I = Interactor
public struct Interactor { private init() {} }

public typealias R = Router
public struct Router { private init() {} }

public typealias AlertType = RJSLib.AlertType

#if !os(macOS)
public typealias RJS_BaseGenericViewVIP = RJSLib.BaseGenericViewVIP
public typealias RJS_BaseGenericViewControllerVIP = RJSLib.BaseGenericViewControllerVIP
public typealias RJS_BaseViewControllerVIP = RJSLib.BaseViewControllerVIP
public typealias RJS_BaseInteractorVIP = RJSLib.BaseInteractorVIP
public typealias RJS_BasePresenterVIP = RJSLib.BasePresenterVIP

public typealias RJS_BaseDisplayLogicModels = RJSLib.BaseDisplayLogicModels
public typealias RJS_BaseRouterVIP = RJSLib.BaseRouterVIP
#endif
