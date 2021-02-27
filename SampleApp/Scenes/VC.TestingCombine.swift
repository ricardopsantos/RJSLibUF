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

        public class SomeObservableObject: ObservableObject {
            public init() { }
            var willChangeRelay = PassthroughSubject<SomeObservableObject, Never>()
            var didChangeRelay = PassthroughSubject<SomeObservableObject, Never>()
            public var someValue: String? {
                willSet {
                    RJS_Logs.info("\(Self.self) willSet")
                    willChangeRelay.send(self)
                }
                didSet {
                    RJS_Logs.info("\(Self.self) didSet")
                    didChangeRelay.send(self)
                }
            }
        }
        
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

        private func btnWith(text: String) -> RJS_Designables_UIKit.ButtonPrimary {
            RJS_Designables_UIKit.ButtonPrimary(text: text, font: font, fontColor: fontColor, buttonColor: primary)
        }
        
        private lazy var btn1_multipleSubscrivers: RJS_Designables_UIKit.ButtonPrimary = {
            btnWith(text: "btn1_multipleSubscrivers")
        }()
        
        private lazy var btn2_subjectToPublisher: RJS_Designables_UIKit.ButtonPrimary = {
            btnWith(text: "btn2_subjectToPublisher")
        }()
        
        private lazy var btn3_currentValueSubject: RJS_Designables_UIKit.ButtonPrimary = {
            btnWith(text: "btn3_currentValueSubject")
        }()
        
        private lazy var btn4_handleEvents: RJS_Designables_UIKit.ButtonPrimary = {
            btnWith(text: "btn4_handleEvents")
        }()
        
        private lazy var btn5_combineLatest: RJS_Designables_UIKit.ButtonPrimary = {
            btnWith(text: "btn5_combineLatest")
        }()
        
        private lazy var btn6_observedObject: RJS_Designables_UIKit.ButtonPrimary = {
            btnWith(text: "btn6_observedObject")
        }()
        
        //
        // Combine
        //
        
        let relay1    = PassthroughSubject<String, Never>()
        let relay2    = PassthroughSubject<String, CustomAppError>()
        let variable1 = CurrentValueSubject<String, Never>("variable1 init") // Will emit immediately and can hold and relay the latest value subscribers
        @ObservedObject var delegate: VC.TestingCombine.SomeObservableObject

        //
        // ViewController
        //
        override func prepareLayout() {
            view.backgroundColor = RJS_ColorPack3.background.color
            view.layouts.addAndSetup(scrollView: scrollView, with: stackViewVLevel1, usingSafeArea: true)
            stackViewVLevel1.rjs.add(searchBar)
            stackViewVLevel1.rjs.add(label)
            stackViewVLevel1.rjs.add(switchPublisher)
            stackViewVLevel1.rjs.add(btn1_multipleSubscrivers)
            stackViewVLevel1.rjs.add(btn2_subjectToPublisher)
            stackViewVLevel1.rjs.add(btn3_currentValueSubject)
            stackViewVLevel1.rjs.add(btn4_handleEvents)
            stackViewVLevel1.rjs.add(btn5_combineLatest)
            stackViewVLevel1.rjs.add(btn6_observedObject)
            
            _ = view.rjs.allSubviews.filter { $0.isKind(of: UIButton.self) }.map { $0.layouts.height(44) }
            label.numberOfLines = 0
        }
        
        override func setupFRP() {
            let someObject = MyClass()
            
            //
            // Search Bar -> View Controller
            //
            
            searchBar
                .textDidChangePublisher
                .sink { [weak self] (value) in
                    self?.display("searchBar: \(value)", override: false)
                }.store(in: cancelBag)
            
            //
            // Switch -> View Controller
            //
            
            switchPublisher.isOnPublisher.assign(to: \.someProp, on: self).store(in: cancelBag)

            //
            // Switch -> computed var
            //
            
            switchPublisher.isOnPublisher.assign(to: \.property, on: someObject).store(in: cancelBag)
            /*:
            # Subjects
            - A subject is a publisher ...
            - ... relays values it receives from other publishers ...
            - ... can be manually fed with new values
            - ... subjects as also subscribers, and can be used with `subscribe(_:)`
            */
            
            //
            // btn1_multipleSubscrivers
            // Using a subject to relay values to subscribers
            //
            
            btn1_multipleSubscrivers.rjsCombine.onTouchUpInside.sinkToResult { [weak self] (some) in
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
            // btn2_subjectToPublisher
            // Subscribing a subject to a publisher
            //
            
            let publisher = ["1","2","3"].publisher
            btn2_subjectToPublisher.rjsCombine.onTouchUpInside.sinkToResult { [weak self] (some) in
                guard let self = self else { return }
                publisher.subscribe(self.relay1).store(in: self.cancelBag)
            }.store(in: cancelBag)
            
            //
            // btn3_currentValueSubject
            // Using a `CurrentValueSubject` to hold and relay the latest value to new subscribers
            //
            
            let subscription3 = variable1
            
            btn3_currentValueSubject.rjsCombine.onTouchUpInside.sinkToResult { [weak self] (some) in
                self?.variable1.send(String.random(3))
                RJS_Utils.delay(1) { [weak self] in
                    self?.display("variable1 value: \(String(describing: self?.variable1.value))", override: false)
                }
            }.store(in: cancelBag)
            
            subscription3.sink { [weak self] value in
                self?.display("subscription3 value: \(value)", override: false)
            }.store(in: cancelBag)
            
            //
            // btn4_handleEvents
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
                
            btn4_handleEvents.rjsCombine.onTouchUpInside.sinkToResult { [weak self] (some) in
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
            // btn5_combineLatest
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

            btn5_combineLatest.rjsCombine.onTouchUpInside.sinkToResult { [weak self] (some) in
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
            
            /*:
            ## `ObservedObject`
 
             */
            
            btn6_observedObject.rjsCombine.onTouchUpInside.sinkToResult { [weak self] (some) in
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
