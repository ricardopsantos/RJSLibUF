//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation

public struct RJSLibExtension<Target> {
    public let target: Target
    init(_ target: Target) { self.target = target }
}

public protocol RJSLibExtensionCompatible { }

public extension RJSLibExtensionCompatible {
    var rjs: RJSLibExtension<Self> { return RJSLibExtension(self) }                   /* instance extension */
    static var rjs: RJSLibExtension<Self>.Type { return RJSLibExtension<Self>.self }  /* static extension */
}

extension NSObject: RJSLibExtensionCompatible { }
