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

#if canImport(SwiftUI) && DEBUG
struct TabBarController_ViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView { return TabBarControllerV1().view }
    func updateUIView(_ view: UIView, context: Context) { }
}
struct TabBarControllerPreview: PreviewProvider {
    //static var previews: some View { TabBarController_ViewRepresentable().buildPreviews() }
    static var previews: some View { TabBarControllerV2() }
}
#endif

struct TabBarControllerV2: View {
    
    var vcCombineTesting: VC.CombineTestingVC {
        VC.CombineTestingVC(
            viewStateBinder1: RJS_GenericObservableObjectForHashable<String>(),
            viewStateBinder2: RJS_GenericObservableObjectForHashableWithObservers<String>())
    }
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: V.PrimeApp.ContentView(store: AppStores.PrimeApp().store)) { Text("PrimeApp") }
                
                NavigationLink(destination: RJSLibUFBase_Preview.ConditionalViews()) {
                    Text("ConditionalViews") }
                
                NavigationLink(destination: vcCombineTesting.asAnyView) {
                    Text("CombineTestingVC") }
                
                NavigationLink(destination: VC.SwiftUIAndUIKitVC().asAnyView) {
                    Text("SwiftUIAndUIKitVC") }
                
                NavigationLink(destination: VC.RJSLibUFDesignablesVC().asAnyView) {
                    Text("RJSLibUFDesignablesVC") }
                
                NavigationLink(destination: VC.RJSLibUFAppThemesVC().asAnyView) {
                    Text("RJSLibUFAppThemesVC") }
                
                NavigationLink(destination: VC.TestingMiscVC().asAnyView) {
                    Text("TestingMiscVC") }
                
            }
            .navigationBarTitle("RJSLib_UseCases")
        }
    }
}

class TabBarControllerV1: UITabBarController {
    var viewStateBinder1 = RJS_GenericObservableObjectForHashable<String>()
    var viewStateBinder2 = RJS_GenericObservableObjectForHashableWithObservers<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        let cancelBag = CancelBag()
                
        let swiftUIView1 = V.PrimeApp.ContentView(store: AppStores.PrimeApp().store).viewController
        let swiftUIView2 = RJSLibUFBase_Preview.ConditionalViews().viewController
        let v0 = createControllers(tabName: "SwiftUIView", vc: swiftUIView1)
        let v1 = createControllers(tabName: "Combine", vc: VC.CombineTestingVC(viewStateBinder1: viewStateBinder1, viewStateBinder2: viewStateBinder2))
        let v2 = createControllers(tabName: "SwiftUI", vc: VC.SwiftUIAndUIKitVC())
        let v3 = createControllers(tabName: "Desinables", vc: VC.RJSLibUFDesignablesVC())
        let v4 = createControllers(tabName: "DLanguage", vc: VC.RJSLibUFAppThemesVC())
        let v5 = createControllers(tabName: "Testing", vc: VC.TestingMiscVC())
                
        viewControllers = [v0, v1, v2, v3, v4, v5]
        
        viewStateBinder1.value.sink { (some) in
            RJS_Logs.info("new value: \(some)")
        }.store(in: cancelBag)
        
        viewStateBinder2.didChange.sink { (some) in
            RJS_Logs.info("new value: \(String(describing: some.value))")
        }.store(in: cancelBag)
    }

    private func createControllers(tabName: String, vc: UIViewController) -> UINavigationController {
        let tabVC = UINavigationController(rootViewController: vc)
        tabVC.setNavigationBarHidden(true, animated: false)
        tabVC.tabBarItem.image = UIImage(systemName: "heart")
        tabVC.tabBarItem.title = tabName
        return tabVC
    }
}
