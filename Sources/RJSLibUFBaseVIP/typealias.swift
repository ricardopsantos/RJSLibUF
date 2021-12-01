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
public typealias RJS_BaseGenericView           = RJSLib.BaseGenericView
public typealias RJS_BaseGenericViewController = RJSLib.BaseGenericViewController
public typealias RJS_BaseViewController        = RJSLib.BaseViewController
public typealias RJS_BaseInteractor            = RJSLib.BaseInteractor
public typealias RJS_BasePresenter             = RJSLib.BasePresenter
public typealias RJS_BaseRouter                = RJSLib.BaseRouter

public typealias RJS_BaseDisplayLogicModels = RJSLib.BaseDisplayLogicModels
#endif
