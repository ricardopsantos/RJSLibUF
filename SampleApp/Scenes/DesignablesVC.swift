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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        RJS_Utils.delay(0.1) { [weak self] in
            self?.view.rjs.startActivityIndicator(style: .slidingCircles)
            RJS_Utils.delay(3) {  [weak self] in
                self?.view.rjs.stopActivityIndicator()
            }
        }
    }
    
    func prepareLayout() {
        self.view.backgroundColor = .white
    }
}

