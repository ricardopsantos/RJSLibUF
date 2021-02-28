//
//  Created by Ricardo Santos on 28/02/2021.
//

import Foundation

//
// https://medium.com/flawless-app-stories/turning-property-wrappers-into-function-wrappers-2be3a49229f5
// Turning Property Wrappers into Function Wrappers
//

public extension RJSLib {
    @propertyWrapper
    struct CachedFunction<Input: Hashable, Output> {
        
        private var cachedFunction: (Input) -> Output

        public init(wrappedValue: @escaping (Input) -> Output) {
            self.cachedFunction = CachedFunction.addCachingLogic(to: wrappedValue)
        }
        
        public var wrappedValue: (Input) -> Output {
            get { return self.cachedFunction }
            set { self.cachedFunction = CachedFunction.addCachingLogic(to: newValue) }
        }
        
        private static func addCachingLogic(to function: @escaping (Input) -> Output) -> (Input) -> Output {
            var cache: [Input: Output] = [:]
            
            return { input in
                if let cachedOutput = cache[input] {
                    return cachedOutput
                } else {
                    let output = function(input)
                    cache[input] = output
                    return output
                }
            }
        }
    }
}

fileprivate extension RJSLib {
    struct Trigo {
        @RJS_CachedFunction static var cachedCos = { (x: Double) in cos(x) }
    }
    
    func sample() {
        _ = Trigo.cachedCos(.pi * 2) // takes 48.85 µs
        // value of cos for 2π is now cached
        _ = Trigo.cachedCos(.pi * 2) // takes 0.13 µs
    }
}
