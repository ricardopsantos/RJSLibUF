//
//  Created by Ricardo Santos on 19/03/2021.
//

import Foundation
import Combine
#if !os(macOS)
import UIKit

//
// https://medium.com/swlh/save-your-animation-code-from-callback-hell-with-combine-27b8a0961fa9
// Combine: The savior of iOS animation in Swift
//

public extension UIView {
    class func animationPublisher(withDuration duration: TimeInterval, animations: @escaping () -> Void) -> Future<Bool, Never> {
        Future { promise in
            UIView.animate(withDuration: duration, animations: animations) {
                promise(.success($0))
            }
        }
    }
    
    class func animationPublisher(withDuration duration: TimeInterval,
                                  delay: TimeInterval,
                                  options: UIView.AnimationOptions = [],
                                  animations: @escaping () -> Void) -> Future<Bool, Never> {
        Future { promise in
            UIView.animate(withDuration: duration, delay: delay, options: options, animations: animations) {
                promise(.success($0))
            }
        }
    }
    
    class func animationPublisher(withDuration duration: TimeInterval,
                                  delay: TimeInterval,
                                  usingSpringWithDamping dampingRatio: CGFloat,
                                  initialSpringVelocity
                                    velocity: CGFloat,
                                  options: UIView.AnimationOptions = [],
                                  animations: @escaping () -> Void) -> Future<Bool, Never> {
        Future { promise in
            UIView.animate(withDuration: duration,
                           delay: delay,
                           usingSpringWithDamping: dampingRatio,
                           initialSpringVelocity: velocity,
                           options: options,
                           animations: animations) {
                promise(.success($0))
            }
        }
    }
}

private func sample1() {
    var cancellables: Set<AnyCancellable> = []
    let cube = UIView()
    let view = UIView()
    
    UIView.animationPublisher(withDuration: 1.5) {
        cube.center = view.center
    }
        .flatMap { /*isCompleted*/ _ in
            UIView.animationPublisher(withDuration: 1.0) {
                cube.backgroundColor = .blue
                cube.layer.bounds.size = CGSize(width: 100.0, height: 100.0)
            }
        }
        .flatMap { /*isCompleted*/ _ in
            UIView.animationPublisher(withDuration: 0.5) {
                cube.layer.cornerRadius = 50.0
                cube.transform = CGAffineTransform(rotationAngle: .pi)
            }
        }
        .sink(receiveValue: { isCompleted in
            RJS_Logs.debug("animation completed ? \(isCompleted)", tag: .rjsLib)
        })
        .store(in: &cancellables)
}
#endif
