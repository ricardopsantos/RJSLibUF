//
//  Created by Ricardo Santos on 22/01/2021.
//

import Foundation

#if !os(macOS)
import UIKit
//
import RJSLibUFBase

// Future way to handle apps DarkMode (on progress)

public protocol StylableProtocol: class {
    
    // This object is used to apply any custom behavior associated with
    // an Stylable, so this way we'll not overload our Stylable components.

    var stylesHandler: StylesHandler { get set }

    // Every apply of colors and Styles that must be dynamic must be set
    // inside the implementation of this function. This gonna be called
    // on key places like `traitCollectionDidChange()` and also at the
    // init and draw methods so this way you just need to override it
    // and set your styles there.

    func setupColorsAndStyles()
}

open class StylableView: UIView, StylableProtocol {

    public var stylesHandler: StylesHandler = StylesHandler()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        commonInit()
    }

    private func commonInit() {
        setupColorsAndStyles()
    }

    open func setupColorsAndStyles() {
        stylesHandler.stylesToSetAfterSetupColorsAndStyles?()
    }

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupColorsAndStyles()
    }
}

public class StylesHandler {

    public init() {}

    // This callback must be called after setupColorsAndStyles,
    // so if you need to define some styles or dynamic colors inside
    // your views that you are not able to define inside
    // setupColorsAndStyles() you can set this callback with your
    // style definitions

    // Example:
    // myLabel.styleHandler.stylesToSetAfterSetupColorsAndStyles = {
    //     myLabel.applyStyle(.someStyleImSettingOutsideSetupColorsAndStyles)
    // }

    public var stylesToSetAfterSetupColorsAndStyles: (() -> Void)? {
        didSet {
            stylesToSetAfterSetupColorsAndStyles?()
        }
    }

    // This holds a reference to the current style so if the style changes
    // and the superclass is already implementing a style, the newer style
    // will be keeped

    //public var currentStyle: ViewStyle?
}

// public class ViewStyle: Decodable { }
#endif
