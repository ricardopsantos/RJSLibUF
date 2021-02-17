//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import Foundation
import UIKit

public extension RJSLibExtension where Target == UIImageView {
    func load(url: URL, downsample: Bool = true) { target.load(url: url, downsample: downsample) }
}

public extension UIImageView {

    func load(url: URL, downsample: Bool = true) {
        //(self as UIView).rjs.startActivityIndicator(style: .pack2_2)
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    //(self as UIView).rjs.stopActivityIndicator()
                    if downsample {
                        self.image = UIImage.downsample(imageAt: url, to: self.bounds.size)
                    } else {
                        self.image = image
                    }
                }
            }
        }
    }
}
#endif
