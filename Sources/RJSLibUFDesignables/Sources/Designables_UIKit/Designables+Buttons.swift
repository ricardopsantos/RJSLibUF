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
            label.layouts.topToBottom(of: button)
            label.layouts.leftToSuperview()
            label.layouts.rightToSuperview()
            //label.layouts.height(Self.btnDefaultH)
            label.layouts.bottomToSuperview()
            label.textAlignment = .center
        }
    }

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
            /*label.layouts.topToSuperview()
            label.layouts.leftToSuperview()
            label.layouts.rightToSuperview()*/
            label.layouts.height(Self.btnDefaultH)
        }
    }
    
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


struct Previews_CustomButtonsVC {
    
    class CustomButtonsVC: UIViewController {
        
        private let font = RJS_Fonts.Styles.paragraphMedium.rawValue
        private let fontColor = RJS_ColorPack3.onPrimary.color
        private let primary = RJS_ColorPack3.primary.color
        private let image = UIImage(color: RJS_ColorPack3.primary.color, size: CGSize(width: 30, height: 30))!

        private lazy var scrollView: UIScrollView = { RJS_UIFactory.scrollView() }()
        private lazy var stackViewVLevel1: UIStackView = { RJS_UIFactory.stackView(axis: .vertical) }()

        override func loadView() {
            super.loadView()
            view.layouts.addAndSetup(scrollView: scrollView, with: stackViewVLevel1, usingSafeArea: true)
            
            let views = [RJS_Designables_UIKit.ButtonPrimary(title: "Primary"),
                         RJS_Designables_UIKit.ButtonSecondary(title: "Secondary"),
                         RJS_Designables_UIKit.ButtonSecondaryDestructive(title: "SecondaryDestructive"),
                         RJS_Designables_UIKit.ButtonAccept(title: "Accept"),
                         RJS_Designables_UIKit.ButtonReject(title: "Reject"),
                         RJS_Designables_UIKit.ButtonRemind(title: "Remind"),
                         RJS_Designables_UIKit.ButtonInnGage(title: "InnGage"),
                         RJS_Designables_UIKit.ButtonText(text: "ButtonText",
                                                                     font: font,
                                                                     color: primary),
                         RJS_Designables_UIKit.ButtonIcon(image: image, color: primary),
                         RJS_Designables_UIKit.ButtonIconAndText(text: "ButtonIconAndText",
                                                                            image: image,
                                                                            font: font,
                                                                            color: primary)]
                    
            views.forEach { (some) in
                stackViewVLevel1.rjs.add(some)
                stackViewVLevel1.rjs.addSeparator(color: primary)
            }

        }
    }

    
    struct Preview1: PreviewProvider {
        public static var previews: some View {
            RJS_ViewControllerRepresentable { CustomButtonsVC() }.buildPreviews()
        }
    }
}

#endif
