//
//  Created by Ricardo Santos on 09/03/2021.
//

import Foundation

//
// https://medium.com/codex/swift-create-your-own-custom-operator-a6fe4d71f606
//

// swiftlint:disable shorthand_operator
prefix operator ✔️
prefix func ✔️(num: Double) -> Double {
    return sqrt(num)
}

infix operator ➕
func ➕(lhs: Int, rhs: Int) -> Int {
    return lhs + rhs // regular + operator
}

infix operator ➗=
func ➗=(lhs: inout Double, rhs: Double) {
    lhs = lhs / rhs
}

func factorial(_ n: Int) -> Double {
  return (1...n).map(Double.init).reduce(1.0, *)
}

postfix operator ❗
postfix func ❗(num: Int) -> Double {
    return factorial(num)
}

fileprivate extension RJSLib {
    func sample() {
        RJS_Logs.debug(✔️25.0, tag: .rjsLib) // prints 5.0
        RJS_Logs.debug(3 ➕ 6, tag: .rjsLib) // prints 9
        RJS_Logs.debug(5❗, tag: .rjsLib) // prints 120.0
        
        var num = 14.0
        num ➗= 2.0
        RJS_Logs.debug(num, tag: .rjsLib) // prints 7.0
    }
}
// swiftlint:enable shorthand_operator
