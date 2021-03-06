//
//  Created by Ricardo Santos on 23/02/2021.
//

#if !os(macOS)
import Foundation
import UIKit
import SwiftUI
//
import RJSLibUFBase
import RJSLibUFAppThemes

public extension RJS_Designables_UIKit {
    class BaseButton: UIControl {
        fileprivate static var btnDefaultH: CGFloat { 44 }
        fileprivate let container = UIView()
        fileprivate let button = UIButton(type: .custom)

        fileprivate let label = UILabel()

        fileprivate init() {
            super.init(frame: .zero)
            prepareBaseLayout()
        }

        public init(title: String, style: RJS_ButtontStyle) {
            super.init(frame: .zero)
            button.layoutStyle = style
            button.rjs.setTitleForAllStates(title)
            prepareBaseLayout()
            label.removeFromSuperview()
        }
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            prepareBaseLayout()
        }

        public required init?(coder: NSCoder) {
            super.init(coder: coder)
            prepareBaseLayout()
        }
        
        func prepareBaseLayout() {
            addSubview(container)
            container.addSubview(button)
            container.addSubview(label)
            container.layouts.edgesToSuperview()
                    
            container.isUserInteractionEnabled = true
            container.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
            
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
            label.textAlignment = .center
            label.numberOfLines = 0

            button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)

            prepareLayout()
        }
        
        @objc fileprivate func handleTap() {
            sendActions(for: .touchUpInside)
        }
        
        func prepareLayout() {
            fatalError("override me")
        }
    }
}

public extension RJS_Designables_UIKit {

    class ButtonPrimary: BaseButton {
        public init(title: String) { super.init(title: title, style: .primary) }
        public required init?(coder: NSCoder) { fatalError() }
        override func prepareLayout() {
            button.layouts.edgesToSuperview()
            button.layouts.height(Self.btnDefaultH)
        }
    }

    class ButtonSecondary: BaseButton {
        public init(title: String) { super.init(title: title, style: .secondary) }
        public required init?(coder: NSCoder) { fatalError() }
        override func prepareLayout() {
            button.layouts.edgesToSuperview()
            button.layouts.height(Self.btnDefaultH)
        }
    }
    
    class ButtonSecondaryDestructive: BaseButton {
        public init(title: String) { super.init(title: title, style: .secondaryDestructive) }
        public required init?(coder: NSCoder) { fatalError() }
        override func prepareLayout() {
            button.layouts.edgesToSuperview()
            button.layouts.height(Self.btnDefaultH)
        }
    }
    
    class ButtonAccept: BaseButton {
        public init(title: String) { super.init(title: title, style: .accept) }
        public required init?(coder: NSCoder) { fatalError() }
        override func prepareLayout() {
            button.layouts.edgesToSuperview()
            button.layouts.height(Self.btnDefaultH)
        }
    }
    
    class ButtonReject: BaseButton {
        public init(title: String) { super.init(title: title, style: .reject) }
        public required init?(coder: NSCoder) { fatalError() }
        override func prepareLayout() {
            button.layouts.edgesToSuperview()
            button.layouts.height(Self.btnDefaultH)
        }
    }
    
    class ButtonRemind: BaseButton {
        public init(title: String) { super.init(title: title, style: .remind) }
        public required init?(coder: NSCoder) { fatalError() }
        override func prepareLayout() {
            button.layouts.edgesToSuperview()
            button.layouts.height(Self.btnDefaultH)
        }
    }
    
    class ButtonInnGage: BaseButton {
        public init(title: String) { super.init(title: title, style: .inngage) }
        public required init?(coder: NSCoder) { fatalError() }
        override func prepareLayout() {
            button.layouts.edgesToSuperview()
            button.layouts.height(Self.btnDefaultH)
        }
    }

    class ButtonIconAndText: BaseButton {
        public init(title: String,
                    image: UIImage,
                    font: UIFont? = RJS_Fonts.Styles.paragraphMedium.rawValue,
                    color: UIColor? = RJS_ColorPack3.onPrimary.color) {
            super.init()
            button.rjs.setImageForAllStates(image, tintColor: color)
            label.text = title
            label.numberOfLines = 0
            if let font = font {
                label.font = font
            }
            if let color = color {
                label.textColor = color
            }
        }
        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func prepareLayout() {
            button.layouts.centerX(to: container)
            button.layouts.topToSuperview()
            button.layouts.height(Self.btnDefaultH)
            button.layouts.width(Self.btnDefaultH)
            label.layouts.topToBottom(of: button)
            label.layouts.leftToSuperview()
            label.layouts.rightToSuperview()
            //label.layouts.height(Self.btnDefaultH)
            label.layouts.bottomToSuperview()
            label.textAlignment = .center
        }
    }

    class ButtonText: BaseButton {
        public init(title: String,
                    font: UIFont? = RJS_Fonts.Styles.paragraphMedium.rawValue,
                    color: UIColor? = RJS_ColorPack3.onPrimary.color) {
            super.init()
            label.text = title
            if let font = font {
                label.font = font
            }
            if let color = color {
                label.textColor = color
            }
        }
        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func prepareLayout() {
            button.removeFromSuperview()
            label.layouts.edgesToSuperview()
            /*label.layouts.topToSuperview()
            label.layouts.leftToSuperview()
            label.layouts.rightToSuperview()*/
            label.layouts.height(Self.btnDefaultH)
        }
    }
    
    class ButtonIcon: BaseButton {
        public init(image: UIImage,
                    color: UIColor? = RJS_ColorPack3.primary.color) {
            super.init()
            button.rjs.setImageForAllStates(image, tintColor: color)
        }
        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func prepareLayout() {
            container.layouts.height(Self.btnDefaultH)
            button.layouts.centerX(to: container)
            button.layouts.topToSuperview()
            button.layouts.height(Self.btnDefaultH)
            button.layouts.width(Self.btnDefaultH)
            label.removeFromSuperview()
        }
    }
}

#endif
