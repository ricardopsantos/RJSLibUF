//
//  Created by Ricardo Santos on 06/03/2021.
//
#if !os(macOS)
import Foundation
import UIKit
import SwiftUI
//
import RJSLibUFBase

public struct RJSLibUFBaseVIP {
    #if canImport(SwiftUI) && DEBUG
    struct Preview: PreviewProvider {
        static var previews: some View { RJS_ViewControllerRepresentable {
            //VC.___VARIABLE_sceneName___ViewController()
            UIViewController()
        }.buildPreviews() }
    }
    #endif
}
#endif
