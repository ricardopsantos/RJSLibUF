//
//  TabBarController.swift
//  SampleApp
//
//  Created by Ricardo Santos on 14/02/2021.
//
import UIKit
import Foundation
import Combine
import SwiftUI
//
import RJSLibUFBase
import RJSLibUFBaseVIP

class TabBarController: UITabBarController {

    let customDelegate = VC.TestingCombine.SomeObservableObject()

    override func viewDidLoad() {
        super.viewDidLoad()
        let cancelBag = CancelBag()
        
        customDelegate.didChangeRelaySubject.sink { (some) in
            print("new value: \(some)")
        }.store(in: cancelBag)
        
        let v1 = createControllers(tabName: "Combine", vc: VC.TestingCombine(delegate: customDelegate))
        let v2 = createControllers(tabName: "SwiftUI", vc: VC.SwiftUIAndUIKitVC())
        let v3 = createControllers(tabName: "Desinables", vc: VC.DesinablesVC())
        let v4 = createControllers(tabName: "DLanguage", vc: VC.DesignLanguageVC())
        let v5 = createControllers(tabName: "Testing", vc: VC.TestingMiscVC())
        var vcs = [v1, v2, v3, v4, v5]
        #if INCLUDE_VIP_TEMPLATE
        vcs.append(createControllers(tabName: "VIP", vc: VC.___VARIABLE_sceneName___ViewController()))
        #endif
        
        viewControllers = vcs
    }

    private func createControllers(tabName: String, vc: UIViewController) -> UINavigationController {
        let tabVC = UINavigationController(rootViewController: vc)
        tabVC.setNavigationBarHidden(true, animated: false)
        tabVC.tabBarItem.image = UIImage(systemName: "heart")
        tabVC.tabBarItem.title = tabName
        return tabVC
    }
}
