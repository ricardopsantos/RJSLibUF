//
//  Created by Ricardo Santos on 20/01/2021.
//

#if !os(macOS)
import Foundation
import UIKit
import RJSLibUFBase

public extension UIStackView {
    
    func addSectionForDevScreen(title: String, font: UIFont = RJS_Fonts.Styles.paragraphBold.rawValue) {
        let label = UILabel()
        label.text = title
        label.font = font
        label.textAlignment = .center
        
        let separator1 = UIView()
        let separator2 = UIView()
        let separator3 = UIView()
        separator1.backgroundColor = UIColor.Pack3.primary.rawValue
        separator2.backgroundColor = UIColor.clear
        separator2.backgroundColor = UIColor.clear
        self.add(separator3)
        self.add(separator1)
        self.add(label)
        self.add(separator2)
        separator1.heightAnchor.constraint(equalToConstant: 3).isActive = true
        separator2.heightAnchor.constraint(equalToConstant: 10).isActive = true
        separator3.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    // Will add a visual report on the stack view for easy understanding of about the available design languages
    func buildAndAddReport() {
        
        addSectionForDevScreen(title: "RJS_Fonts: \(RJS_Fonts.Styles.allCases.count) values")
        RJS_Fonts.Styles.allCases.forEach { (some) in
            self.add(some.reportView)
        }
        
        addSectionForDevScreen(title: "RJS_Color.Pack3: \(RJS_ColorPack3.allCases.count) values")
        RJS_ColorPack3.allCases.forEach { (some) in
            let reportView = some.reportView
            self.add(some.reportView)
            reportView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        
        addSectionForDevScreen(title: "RJS_Color.Pack1: \(UIColor.Pack1.allCases.count) values")
        RJS_ColorPack1.allCases.forEach { (some) in
            let reportView = some.reportView
            self.add(some.reportView)
            reportView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        
        addSectionForDevScreen(title: "RJS_Color.Pack2: \(UIColor.Pack2.allCases.count) values")
        RJS_ColorPack2.allCases.forEach { (some) in
            let reportView = some.reportView
            self.add(some.reportView)
            reportView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        
        addSectionForDevScreen(title: "RJS_SizeNames: \(RJS_SizeNames.allCases.count) values")
        RJS_SizeNames.allCases.forEach { (some) in
            let reportView = UILabel()
            reportView.text = "\(some) | \(some.rawValue)"
            reportView.font = RJS_Fonts.Styles.paragraphSmall.rawValue
            self.add(reportView)
        }
        
    }

}
#endif
