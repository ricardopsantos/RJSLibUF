//
//  Delegated.swift
//  RJSLibUFBase
//
//  Created by Ricardo Santos on 07/02/2021.
//

import Foundation
#if !os(macOS)
import UIKit
#endif

/**
 https://olegdreyman.medium.com/no-more-weak-self-or-the-weird-new-future-of-delegation-f2a2745cd73
 https://github.com/dreymonde/Delegated
 
 __@AppStorage__
 A property wrapper type that reflects a value from UserDefaults and invalidates a view on a change in value in that user default.
 https://developer.apple.com/documentation/swiftui/appstorage
 */

public extension RJSLib {
    struct Delegated_V1<Input> {
        
        private(set) var callback: ((Input) -> Void)?
        
        public mutating func delegate<Object: AnyObject>(to object: Object, with callback: @escaping (Object, Input) -> Void) {
            self.callback = { [weak object] input in
                guard let object = object else { return }
                callback(object, input)
            }
        }
        
    }
}

public extension RJSLib {
    @propertyWrapper
    final class Delegated_V2<Input> {
        
        public init() {
            self.callback = { _ in }
        }
        
        private var callback: (Input) -> Void
        
        public var wrappedValue: (Input) -> Void {
            return callback
        }
        
        public var projectedValue: Delegated_V2<Input> {
            return self
        }
        
        func delegate<Target: AnyObject>(
            to target: Target,
            with callback: @escaping (Target, Input) -> Void
        ) {
            self.callback = { [weak target] input in
                guard let target = target else {
                    return
                }
                return callback(target, input)
            }
        }
    }
}

//
// USAGE
//

#if !os(macOS)
private extension RJSLib {
    struct SampleDelegate {
        
        class SampleButton: UIButton {
            @RJSLib.Delegated_V2 var didPress: (()) -> Void
        }

        class SampleScrollView: UIScrollView {
            @RJSLib.Delegated_V2 var didScrollTo: ((x: CGFloat, y: CGFloat)) -> Void
        }
        
        class SampleTextField_V1: UITextField {
            var didUpdate = RJSLib.Delegated_V1<String>()
            private func didFinishEditing() {
                didUpdate.callback?(self.text ?? "")
            }
        }

        class SampleTextField_V2: UITextField {
            @RJSLib.Delegated_V2 var didUpdate: (String) -> Void
            private func didFinishEditing() {
                self.didUpdate(self.text ?? "")
            }
        }

        class ViewController {
            let label = UILabel()
            let textField_V1 = SampleTextField_V1()
            let textField_V2 = SampleTextField_V2()

            func viewDidLoad() {
                textField_V1.didUpdate.delegate(to: self) { (self, text) in
                    self.label.text = text
                }
                
                textField_V2.$didUpdate.delegate(to: self) { (self, text) in
                    self.label.text = text
                }
            }
        }

    }
}
#endif
