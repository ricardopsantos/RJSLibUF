//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import UIKit
import LocalAuthentication
//
import RJSLibUFBase
import RJSLibUFStorage
import RJSLibUFNetworking
import RJSLibUFAppThemes
import RJSLibUFBaseVIP
import RJSLibUFDesignables

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct RJSLibUFDesignablesVC_PreviewProvider: PreviewProvider {
    static var previews: some View {
        RJS_ViewControllerRepresentable {
            VC.RJSLibUFDesignablesVC()
        }.buildPreviews() }
}
#endif

extension VC {
    class RJSLibUFDesignablesVC: RJSLibUFDesignables_Preview.PreviewVC {

    }
}
