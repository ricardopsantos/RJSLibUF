//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import UIKit
import Combine
import SwiftUI
//
import RJSLibUFBase
import RJSLibUFStorage
import RJSLibUFNetworking
import RJSLibUFAppThemes
import RJSLibUFBaseVIP

extension VC {
    class TestingCombine: GenericViewController {

        required init?(coder: NSCoder) {
            fatalError("init(coder:) is not supported")
        }
        
        init(delegate: SomeObservableObject) {
            self.delegate = delegate
            super.init(nibName: nil, bundle: nil)
        }
        
        //
        // UI Vars
        //
        private lazy var scrollView: UIScrollView = { RJS_UIFactory.scrollView() }()
        private lazy var stackViewVLevel1: UIStackView = { RJS_UIFactory.stackView(axis: .vertical) }()
        
        private lazy var label: UILabel = { UILabel() }()
        private lazy var switchPublisher: UISwitch = { UISwitch() }()
        private lazy var searchBar: RJS_Designables_UIKit.SearchTextField = { RJS_Designables_UIKit.SearchTextField() }()

        private lazy var btn1: RJS_Designables_UIKit.ButtonPrimary = {
            RJS_Designables_UIKit.ButtonPrimary(text: "btn1", font: font, fontColor: fontColor, buttonColor: primary)
        }()
        
        private lazy var btn2: RJS_Designables_UIKit.ButtonPrimary = {
            RJS_Designables_UIKit.ButtonPrimary(text: "btn2", font: font, fontColor: fontColor, buttonColor: primary)
        }()
        
        private lazy var btn3: RJS_Designables_UIKit.ButtonPrimary = {
            RJS_Designables_UIKit.ButtonPrimary(text: "btn3", font: font, fontColor: fontColor, buttonColor: primary)
        }()
        
        private lazy var btn4: RJS_Designables_UIKit.ButtonPrimary = {
            RJS_Designables_UIKit.ButtonPrimary(text: "btn4", font: font, fontColor: fontColor, buttonColor: primary)
        }()
        
        private lazy var btn5: RJS_Designables_UIKit.ButtonPrimary = {
            RJS_Designables_UIKit.ButtonPrimary(text: "btn5", font: font, fontColor: fontColor, buttonColor: primary)
        }()
        
        private lazy var btn6: RJS_Designables_UIKit.ButtonPrimary = {
            RJS_Designables_UIKit.ButtonPrimary(text: "btn6", font: font, fontColor: fontColor, buttonColor: primary)
        }()
        
        //
        // Combine
        //
        
        let relay1    = PassthroughSubject<String, Never>()
        let relay2    = PassthroughSubject<String, CustomAppError>()
        let variable1 = CurrentValueSubject<String, Never>("variable1 init") // Will emit immediately and can hold and relay the latest value subscribers
        @ObservedObject var delegate: SomeObservableObject

        //
        // ViewController
        //
        override func prepareLayout() {
            view.backgroundColor = RJS_ColorPack3.background.color
            view.layouts.addAndSetup(scrollView: scrollView, with: stackViewVLevel1, usingSafeArea: true)
            stackViewVLevel1.rjs.add(searchBar)
            stackViewVLevel1.rjs.add(label)
            stackViewVLevel1.rjs.add(switchPublisher)
            stackViewVLevel1.rjs.add(btn1)
            stackViewVLevel1.rjs.add(btn2)
            stackViewVLevel1.rjs.add(btn3)
            stackViewVLevel1.rjs.add(btn4)
            stackViewVLevel1.rjs.add(btn5)
            stackViewVLevel1.rjs.add(btn6)
            
            _ = view.rjs.allSubviews.filter { $0.isKind(of: UIButton.self) }.map { $0.layouts.height(44) }
            label.numberOfLines = 0
        }
        
        override func setupFRP() {
            let someObject = MyClass()
            
            //
            // Switch -> View Controller
            //
            
            switchPublisher.isOnPublisher.assign(to: \.someProp, on: self).store(in: cancelBag)
            switchPublisher.rjsCombine.isOnPublisher.assign(to: \.property, on: someObject).store(in: cancelBag)

            //
            // Switch -> computed var
            //
            
            switchPublisher.isOnPublisher.assign(to: \.property, on: someObject).store(in: cancelBag)
            switchPublisher.rjsCombine.isOnPublisher.assign(to: \.property, on: someObject).store(in: cancelBag)
            /*:
            # Subjects
            - A subject is a publisher ...
            - ... relays values it receives from other publishers ...
            - ... can be manually fed with new values
            - ... subjects as also subscribers, and can be used with `subscribe(_:)`
            */
            
            //
            // btn1
            // Using a subject to relay values to subscribers
            //
            
            btn1.publisher(for: .touchUpInside).sinkToResult { [weak self] (some) in
                self?.relay1.send(String.random(3))
            }.store(in: cancelBag)
            let subscription1 = relay1
            let subscription2 = relay1
            
            subscription1.sink { [weak self] value in
                self?.display("subscription1 value: \(value)", override: false)
            }.store(in: cancelBag)
            
            subscription2.sink { [weak self] value in
                self?.display("subscription2 value: \(value)", override: false)
            }.store(in: cancelBag)
              
            //
            // btn2
            // Subscribing a subject to a publisher
            //
            
            let publisher = ["1","2","3"].publisher
            btn2.publisher(for: .touchUpInside).sinkToResult { [weak self] (some) in
                publisher.subscribe(self!.relay1)
            }.store(in: cancelBag)
            
            //
            // btn3
            // Using a `CurrentValueSubject` to hold and relay the latest value to new subscribers
            //
            
            let subscription3 = variable1
            
            btn3.publisher(for: .touchUpInside).sinkToResult { [weak self] (some) in
                self?.variable1.send(String.random(3))
                RJS_Utils.delay(1) { [weak self] in
                    self?.display("variable1 value: \(self?.variable1.value)", override: false)
                }
            }.store(in: cancelBag)
            
            subscription3.sink { [weak self] value in
                self?.display("subscription3 value: \(value)", override: false)
            }.store(in: cancelBag)
            
            //
            // btn4
            //
            
            /*:
             ## Subscription details
             - A subscriber will receive a _single_ subscription
             - _Zero_ or _more_ values can be published
             - At most _one_ {completion, error} will be called
             - After completion, nothing more is received
             */
            
            // The handleEvents operator lets you intercept
            // All stages of a subscription lifecycle
            
            let subscription4 = relay2.handleEvents(receiveSubscription: { [weak self] (subscription) in
                self?.display(("subscription4: New subscription!"), override: false) },
                                receiveOutput: { [weak self] _ in self?.display("subscription4: Received new value!", override: false) },
                                receiveCompletion: { [weak self] _ in self?.display("subscription4: A subscription completed", override: false) },
                                receiveCancel: { [weak self] in self?.display("subscription4: A subscription cancelled", override: false) })
                .replaceError(with: "ups... failure")
                
            btn4.publisher(for: .touchUpInside).sinkToResult { [weak self] (some) in
                if Bool.random() {
                    self?.relay2.send(String.random(3))
                } else {
                    self?.relay2.send(completion: .failure(.somethingWentWrong))
                }
            }.store(in: cancelBag)

            subscription4.sink { [weak self] (value) in
                self?.display("subscription4: \(value)", override: false)
            }.store(in: cancelBag)
            
            //
            // btn5
            //
            
            /*:
            ## `CombineLatest`
            - combines values from multiple publishers
            - ... waits for each to have delivered at least one value
            - ... then calls your closure to produce a combined value
            - ... and calls it again every time any of the publishers emits a value
             
            ## `Merge`
            - merges multiple publishers value streams into one
            - ... values order depends on the absolute order of emission amongs all merged publishers
            - ... all publishers must be of the same type.
            */
            
            let relayUserName = PassthroughSubject<String, Never>()
            let relayPassword = PassthroughSubject<String, Never>()
            
            let subscription5 = Publishers.CombineLatest(relayUserName, relayPassword)
            let subscription6 = Publishers.Merge(relayUserName, relayPassword)

            btn5.publisher(for: .touchUpInside).sinkToResult { [weak self] (some) in
                if Bool.random() {
                    relayUserName.send(String.random(3))
                } else {
                    relayPassword.send(String.random(3))
                }
            }.store(in: cancelBag)
            
            relayUserName.sink { [weak self] value in
                self?.display("relayUserName: \(value)", override: false)
            }.store(in: cancelBag)
            
            relayPassword.sink { [weak self] value in
                self?.display("relayPassword: \(value)", override: false)
            }.store(in: cancelBag)
            
            subscription5.map { (value1, value2) -> Bool in
                !value1.isEmpty && !value2.isEmpty
            }.sink { [weak self] value in
                self?.display("subscription5 (CombineLatest): \(value)", override: false)
            }.store(in: cancelBag)
            
            subscription6
                .sink { [weak self] value in
                    self?.display("subscription6 (Merge): \(value)", override: false)
                }.store(in: cancelBag)
            
            
            //
            // Observing search bar changes and pass them to the ViewController via `searchState`
            //
            
            searchBar
                .textDidChangePublisher
                .sink { [weak self] (value) in
                    self?.display("searchBar_A: \(value)", override: false)
                }.store(in: cancelBag)
            
            searchBar
                .valueChangedPublisher
                .sink { [weak self] (value) in
                    self?.display("searchBar_B: \(value)", override: false)
                }.store(in: cancelBag)
            
            btn6.publisher(for: .touchUpInside).sinkToResult { [weak self] (some) in
                self?.delegate.someValue = String.random(5)
            }.store(in: cancelBag)

        }
        
        private var someProp: Bool = false {
            didSet {
                display("\(someProp)", override: true)
            }
        }
    }
}



fileprivate extension VC.TestingCombine {
    private func display(_ message: String, override: Bool) {
        if override {
            label.textAnimated = "\(message)\n"
        } else {
            label.textAnimated = "\(label.text ?? "")\(message)\n"
        }
    }
}
