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

    override func loadView() {
        super.loadView()
        
        let country = Country()
        print(country.name)
        print(country.location)
        print(country.population)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
