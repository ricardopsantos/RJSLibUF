//
//  Created by Ricardo Santos on 11/07/2020.
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
//
import RJSLibUFBase

//
// typealias? Why?
//
// 1 : When using RJSLib on other projects, instead of using `UIFont.RJS_Fonts`, we can use `RJS_Fonts` which can be more elegant to use
// 2 : Also, when using RJSLib, we can type `RJS_` and the Xcode auto-complete feature will suggest only thing inside RJSLib
// 3 : And for last, if one day the module `UIColor.Pack1` changes name for something like `UIColor.PackGrayAndBlue`,
// the external apps using the alias wont need to change anything because the alias stays the same
//

// MARK: - Designables

public typealias RJS_Designables           = RJSLib.Designables
public typealias RJS_Designables_UIKit     = RJSLib.Designables.UIKit
public typealias RJS_Designables_SwiftUI   = RJSLib.Designables.SwiftUI
