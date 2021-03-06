//
// Created by Zé on 09/12/20.
//

#if !os(macOS)
import Foundation
import UIKit

public extension RJSLibExtension where Target == UIView {
    func enableVoiceOver() { target.enableVoiceOver() }
    func disableVoiceOver() { target.disableVoiceOver() }
    
    var voiceOver: String { target.voiceOver }
    var voiceOverHint: String { target.voiceOverHint }
    var voiceOverIsEnabled: Bool { target.voiceOverIsEnabled }

    func setupAccessibilityWith(voiceOver: String, voiceOverHint: String = "") {
        target.setupAccessibilityWith(voiceOver: voiceOver, voiceOverHint: voiceOverHint)
    }
}

public extension RJSLibExtension where Target == UIBarButtonItem {
    var voiceOver: String { target.voiceOver }
    var voiceOverHint: String { target.voiceOverHint }
    var voiceOverIsEnabled: Bool { target.voiceOverIsEnabled }
}

public extension UIView {
    func enableVoiceOver() {
        accessibilityElementsHidden = false
    }

    func disableVoiceOver() {
        accessibilityElementsHidden = true
    }

    var voiceOver: String {
        set { if !newValue.isEmpty { accessibilityLabel = newValue } }
        get { accessibilityLabel ?? "" }
    }

    var voiceOverHint: String {
        set { accessibilityHint = newValue }
        get { accessibilityHint ?? "" }
    }

    var voiceOverIsEnabled: Bool {
        set { isAccessibilityElement = newValue }
        get { isAccessibilityElement }
    }

    func setupAccessibilityWith(voiceOver: String, voiceOverHint: String = "") {
        self.voiceOver = voiceOver
        self.voiceOverHint = voiceOverHint
        if let btn = self as? UIButton { btn.accessibilityTraits = .button }
        if let lbl = self as? UILabel { lbl.accessibilityTraits = .staticText }
    }
}

public extension UIBarButtonItem {
    var voiceOver: String {
        set { if !newValue.isEmpty { self.accessibilityLabel = newValue } }
        get { accessibilityLabel ?? "" }
    }

    var voiceOverHint: String {
        set { accessibilityHint = newValue }
        get { accessibilityHint ?? "" }
    }

    var voiceOverIsEnabled: Bool {
        set { isAccessibilityElement = newValue }
        get { isAccessibilityElement }
    }
}
#endif
