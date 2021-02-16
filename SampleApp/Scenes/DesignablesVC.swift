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
import RJSLibUFALayouts
import RJSLibUFAppThemes

class DesignablesVC: GenericViewController {

    override func loadView() {
        super.loadView()
        prepareLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func displayLoading(style: RJS_Designables_UIKit.ActivityIndicator.Style) {
        view.rjs.startActivityIndicator(style: style)
        RJS_Utils.delay(2) {  [weak self] in
            self?.view.rjs.stopActivityIndicator()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        displayLoading(style: .slidingCircles)
        RJS_Utils.delay(3) { [weak self] in
            self?.displayLoading(style: .pack2_2)
        }
    }
    
    func prepareLayout() {
        self.view.backgroundColor = .white
    }
}
