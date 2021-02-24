//
//  TabBarController.swift
//  SampleApp
//
//  Created by Ricardo Santos on 14/02/2021.
//
import UIKit
import Foundation
import RJSLibUFBase
import RJSLibUFBaseVIP

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let v1 = createControllers(tabName: "SwiftUI", vc: TestingSwiftUIAndUIKitVC())
        let v2 = createControllers(tabName: "VIP", vc: VC.___VARIABLE_sceneName___ViewController())
        let v3 = createControllers(tabName: "Testing", vc: TestingMiscVC())
        let v4 = createControllers(tabName: "Desinables", vc: TestingsDesinablesVC())
        let v5 = createControllers(tabName: "DLanguage", vc: TestingDesignLanguageVC())

        viewControllers = [v1, v2, v3, v4, v5]
    }

    private func createControllers(tabName: String, vc: UIViewController) -> UINavigationController {
        let tabVC = UINavigationController(rootViewController: vc)
        tabVC.setNavigationBarHidden(true, animated: false)
        tabVC.tabBarItem.image = UIImage(systemName: "heart")
        tabVC.tabBarItem.title = tabName
        return tabVC
    }
}
