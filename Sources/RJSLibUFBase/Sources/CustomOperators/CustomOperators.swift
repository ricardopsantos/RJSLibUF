//
//  Created by Ricardo Santos on 09/03/2021.
//

import Foundation

//
// https://medium.com/codex/swift-create-your-own-custom-operator-a6fe4d71f606
//

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
        print(✔️25.0) // prints 5.0
        print(3 ➕ 6) // prints 9
        print(5❗) // prints 120.0
        
        var num = 14.0
        num ➗= 2.0
        print(num) // prints 7.0
    }
}
