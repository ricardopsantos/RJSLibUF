//
//  TabBarController.swift
//  SampleApp
//
//  Created by Ricardo Santos on 14/02/2021.
//
import UIKit
import Foundation

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let v1 = createControllers(tabName: "UFALayouts", vc: LayoutSampleVC())
        let v2 = createControllers(tabName: "SwiftUI", vc: SwiftUIAndUIKitTestingVC())
        viewControllers = [v2, v1]
        
    }

    private func createControllers(tabName: String, vc: UIViewController) -> UINavigationController {
        let tabVC = UINavigationController(rootViewController: vc)
        tabVC.setNavigationBarHidden(true, animated: false)
        tabVC.tabBarItem.image = UIImage(systemName: "heart")
        tabVC.tabBarItem.title = tabName
        return tabVC
    }
}
