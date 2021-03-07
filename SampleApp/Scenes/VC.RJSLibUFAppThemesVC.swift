//
//  Created by Ricardo P Santos on 2020.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import UIKit
//
import RJSLibUFBase
import RJSLibUFStorage
import RJSLibUFNetworking
import RJSLibUFAppThemes
import RJSLibUFBaseVIP
import RJSLibUFDesignables

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct RJSLibUFAppThemesVC_PreviewProvider: PreviewProvider {
    static var previews: some View { RJS_ViewControllerRepresentable { VC.RJSLibUFAppThemesVC() }.buildPreviews() }
}
#endif

extension VC {
    class RJSLibUFAppThemesVC: RJSLibUFAppThemes_Preview.PreviewVC { }
}
