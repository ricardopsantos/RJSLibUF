//
//  Created by Ricardo P Santos on 23/06/2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import UIKit
import Combine
import Foundation

import RJSLibUFBase
import RJSLibUFStorage
import RJSLibUFNetworking
import RJSLibUFAppThemes
import RJSLibUFBaseVIP

extension UIView {
    func lazyLoad() {}
}

class GenericViewController: UIViewController {
    var cancelBag = CancelBag()
    let image = UIImage(named: "image.sample.1")
    let font = RJS_Fonts.Styles.paragraphMedium.rawValue
    let fontColor = RJS_ColorPack3.onPrimary.color
    let primary = RJS_ColorPack3.primary.color
    
    override func loadView() {
        super.loadView()
        prepareLayout()
        setupFRP()
    }
    
    func prepareLayout() { }
    
    func setupFRP() { }
}

let imageURL = "https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Google_Images_2015_logo.svg/1200px-Google_Images_2015_logo.svg.png"

@dynamicMemberLookup
class DynamicMemberLookupCountry {
    subscript(dynamicMember member: String) -> String {
        let properties = ["name": "Bolivia", "location": "South America"]
        return properties[member, default: "NOT FOUND"]
    }
}

class MyClass {
    var property: Bool = false {
        didSet {
            print("Did set property to \(property)")
        }
    }
}

enum CustomAppError: Swift.Error {
    case somethingWentWrong
}

extension VM {
    struct SearchState {
        let value: String
    }
}

