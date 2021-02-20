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

@dynamicMemberLookup
class Country {
  subscript(dynamicMember member: String) -> String {
    let properties = ["name": "Bolivia", "location": "South America"]
    return properties[member, default: "NOT FOUND"]
  }
}

class TestingVC: GenericViewController {

    private var cancelBag = CancelBag()
    private lazy var button1: UIButton = {
        let button = UIButton(type: .system)
        button.rjs.setTitleForAllStates("Touch me 1")
        button.publisher(for: .touchUpInside).sink { button in
            RJS_Logs.debug("\(button) is pressed!", tag: .rjsLib)
        }.store(in: cancelBag)
        return button
    }()
    
    private lazy var button2: UIButton = {
        let button = UIButton(type: .system)
        button.rjs.setTitleForAllStates("Touch me 2")
        button.publisher(for: .touchUpInside).sink { button in
            RJS_Logs.debug("\(button) is pressed!", tag: .rjsLib)
        }.store(in: cancelBag)
        return button
    }()
    
    override func loadView() {
        super.loadView()
        view.addSubview(button1)
        view.addSubview(button2)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        button1.layouts.setSame(.center, as: view)
        button2.layouts.setSame(.centerX, as: view)
        button2.layouts.setMargin(20, on: .top, from: button1)
        
        let country = Country()
        RJS_Logs.debug(country.name, tag: .rjsLib)
        RJS_Logs.debug(country.location, tag: .rjsLib)
        RJS_Logs.debug(country.population, tag: .rjsLib)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
