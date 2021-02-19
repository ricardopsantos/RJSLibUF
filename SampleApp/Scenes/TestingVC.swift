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

    private let button = UIButton(type: .system)
    private var cancelBag = CancelBag()

    override func loadView() {
        super.loadView()
        view.addSubview(button)
        button.rjs.setTitleForAllStates("Touch me")
        button.rjs.view.setSame(layoutAttribute: .center, as: view)
        button.publisher(for: .touchUpInside).sink { button in
            print("Button is pressed!")
        }.store(in: cancelBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let country = Country()
        print(country.name)
        print(country.location)
        print(country.population)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
