import Foundation

/**
 https://github.com/apple/swift-evolution/blob/master/proposals/0258-property-wrappers.md
 https://nshipster.com/propertywrapper/
 https://medium.com/swlh/easy-dependency-injection-with-property-wrappers-in-swift-886a93c28ed4
*/

/**
__If you’re not familiar with Property Wrappers in Swift, it’s not a big deal:__
* We created a struct;
* Added @propertyWrapper before its declaration;
* Every Property Wrapper has to have wrappedValue. In our case, it has a generic type T;
* init gets one parameter: `key` to the variable in UserDefault;

 ```
 class TheViewModel: ObservableObject {
     let objectWillChange = PassthroughSubject<Void, Never>()
     @UserDefaultsPropertyWrapper("ShowOnStart", defaultValue: true)
     var showOnStart: Bool { willSet { objectWillChange.send() } }
 }

 struct VisualDocs_UserDefaultsWithPropertyWrapper: View {
     @ObservedObject var vm = TheViewModel()
     var body: some View {
         VStack {
             Toggle(isOn: $vm.showOnStart) {
                 Text("Show welcome text")
             }
             if vm.showOnStart {
                 Text("Welcome")
             }
         }.padding()
     }
 }
 ```

*/

public extension RJSLib {
    @propertyWrapper
    struct UserDefaults<T> {
        public let key: String
        public let defaultValue: T
        public init(_ key: String, defaultValue: T) {
            self.key = key
            self.defaultValue = defaultValue
        }
        public var wrappedValue: T {
            get { Foundation.UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
            set { Foundation.UserDefaults.standard.set(newValue, forKey: key) }
        }
    }
}

// https://medium.com/flawless-app-stories/turning-property-wrappers-into-function-wrappers-2be3a49229f5
// Turning Property Wrappers into Function Wrappers

/**

 __Sample Usage__

 ```
 struct CachedFunctionsPropertyWrapperTest {
     @CachedFunctionsPropertyWrapper static var cachedCos = { (x: Double) in cos(x) }
 }

 private func teste() {
     CachedFunctionsPropertyWrapperTest.cachedCos(.pi * 2) // takes 48.85 µs
     // value of cos for 2π is now cached
     CachedFunctionsPropertyWrapperTest.cachedCos(.pi * 2) // takes 0
 }
 ```
 
 */
