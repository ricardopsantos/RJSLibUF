//
//  Created by Ricardo Santos on 23/02/2021.
//

#if !os(macOS)
import Foundation
import UIKit

public extension RJSLib.Designables.UIKit {
    class ButtonIcon: BaseButton {
        public init(image: UIImage, color: UIColor? = nil) {
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

public extension RJSLib.Designables.UIKit {
    class ButtonPrimary: BaseButton {
        public init(text: String,
                    font: UIFont,
                    fontColor: UIColor,
                    buttonColor: UIColor) {
            super.init()
            label.text = text
            label.font = font
            label.textColor = fontColor
            label.backgroundColor = buttonColor
            label.layer.cornerRadius = Self.btnDefaultH / 2
            label.clipsToBounds      = true
        }
        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func prepareLayout() {
            label.edgesToSuperview()
            label.layouts.height(Self.btnDefaultH)
        }
    }
}

public extension RJSLib.Designables.UIKit {
    class ButtonSecondary: BaseButton {
        public init(text: String,
                    font: UIFont,
                    color: UIColor) {
            super.init()
            label.text = text
            label.font = font
            label.textColor = color
            label.backgroundColor  = UIColor.white
            label.layer.borderWidth  = 2
            label.layer.borderColor  = color.cgColor
            label.layer.cornerRadius = Self.btnDefaultH / 2
            label.clipsToBounds      = true
        }
        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func prepareLayout() {
            label.edgesToSuperview()
            label.layouts.height(Self.btnDefaultH)
        }
    }
}

public extension RJSLib.Designables.UIKit {
    class ButtonText: BaseButton {
        public init(text: String,
                    font: UIFont,
                    color: UIColor) {
            super.init()
            label.text = text
            label.font = font
            label.textColor = color
        }
        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func prepareLayout() {
            button.removeFromSuperview()
            label.layouts.edgesToSuperview()
        }
    }
}

public extension RJSLib.Designables.UIKit {
    class ButtonIconAndText: BaseButton {
        public init(text: String,
                    image: UIImage,
                    font: UIFont,
                    color: UIColor) {
            super.init()
            button.rjs.setImageForAllStates(image, tintColor: color)
            label.text = text
            label.numberOfLines = 0
            label.font = font
            label.textColor = color
        }
        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func prepareLayout() {
            button.layouts.centerX(to: container)
            button.layouts.topToSuperview()
            button.layouts.height(Self.btnDefaultH)
            button.layouts.width(Self.btnDefaultH)
            label.topToBottom(of: button)
            label.layouts.leftToSuperview()
            label.layouts.rightToSuperview()
            label.layouts.bottomToSuperview()
            label.textAlignment = .center
        }
    }
}

public extension RJSLib.Designables.UIKit {
    class Button: BaseButton {
        public init(text: String,
                    image: UIImage,
                    imageColor: UIColor? = nil,
                    font: UIFont? = nil,
                    fontColor: UIColor? = nil) {
            super.init()
            button.rjs.setImageForAllStates(image, tintColor: imageColor)
            label.text = text
            label.numberOfLines = 0
            if let font = font { label.font = font }
            if let fontColor = fontColor {
                label.textColor = fontColor
            } else if let imageColor = imageColor {
                label.textColor = imageColor
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
            label.topToBottom(of: button)
            label.layouts.leftToSuperview()
            label.layouts.rightToSuperview()
            label.layouts.bottomToSuperview()
            label.textAlignment = .center
        }
    }
}

public extension RJSLib.Designables.UIKit {
    class BaseButton: UIControl {
        fileprivate static var btnDefaultH: CGFloat { 44 }
        fileprivate let container = UIView()
        //fileprivate let button = UIButton(type: .system)
        fileprivate let button = UIButton(type: .custom)

        fileprivate let label = UILabel()

        fileprivate init() {
            super.init(frame: .zero)
            prepareBaseLayout()
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

#endif
