//
//  Created by Ricardo Santos on 28/02/2021.
//

import Foundation

//
// https://medium.com/flawless-app-stories/how-can-property-wrappers-and-function-builders-be-leveraged-d43160de338f
//

public extension RJSLib {
    @propertyWrapper
    struct Expirable <T: ExpressibleByNilLiteral> { // A type that can be initialized using the nil literal, nil.
        
        private let lifetime: TimeInterval
        private var expirationDate: Date = Date()
        private var innerValue: T = nil
                
        public var wrappedValue: T {
            get { value }
            set { value = newValue }
        }
        
        var value: T {
            get { return hasExpired() ? nil : innerValue }
            set {
                self.expirationDate = Date().addingTimeInterval(lifetime)
                self.innerValue = newValue
            }
        }
        
        init(lifetime: TimeInterval) {
            self.lifetime = lifetime
        }
        
        private func hasExpired() -> Bool {
            return expirationDate < Date()
        }
    }
}

fileprivate extension RJSLib {
    struct Tokens {
        /// authent will expire after 3 seconds
        @RJS_Expirable(lifetime: 3) static var authent: String?
    }
    
    func sample() {
        Tokens.authent = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"

        sleep(2)
        RJS_Logs.info(Tokens.authent) // Token is still available
        sleep(2)
        RJS_Logs.info(Tokens.authent) // Token has expired
    }
}
