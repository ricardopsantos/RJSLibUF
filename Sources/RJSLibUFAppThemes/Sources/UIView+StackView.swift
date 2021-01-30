//
//  Created by Ricardo Santos on 20/01/2021.
//

#if !os(macOS)
import Foundation
import UIKit

public extension UIStackView {
    
    func addSectionForDevScreen(title: String, font: UIFont = RJS_Fonts.Styles.paragraphBold.rawValue) {
        let label = UILabel()
        label.text = title
        label.font = font
        label.textAlignment = .center
        
        let separator1 = UIView()
        let separator2 = UIView()
        let separator3 = UIView()
        separator1.backgroundColor = RJS_ColorPack3.primary.rawValue
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
    func loadWithDesignLanguageReport() {
        
        let buttontStyles = RJS_ButtontStyle.allCases.filter { $0 != .notApplied }
        addSectionForDevScreen(title: "RJS_ButtontStyle: \(buttontStyles.count) values")
        buttontStyles.forEach { (some) in
            let reportView = UIButton()
            reportView.layoutStyle = some
            reportView.setTitleForAllStates("\(some)")
            self.add(reportView)
            reportView.heightAnchor.constraint(equalToConstant: UIButton.buttonDefaultSize.height).isActive = true
        }
        
        let labelStyles = RJS_LabelStyle.allCases.filter { $0 != .notApplied }
        addSectionForDevScreen(title: "RJS_LabelStyle: \(labelStyles.count) values")
        labelStyles.forEach { (some) in
            let reportView = UILabel()
            reportView.text = " \(some)"
            reportView.layoutStyle = some
            self.add(reportView)
            reportView.heightAnchor.constraint(equalToConstant: UIButton.buttonDefaultSize.height).isActive = true
            let reportView2 = UILabel()
            reportView2.text = "\(some)"
            reportView2.layoutStyle = some
            reportView2.backgroundColor = UIColor.black.withAlphaComponent(0.1)
            self.add(reportView2)
            reportView2.heightAnchor.constraint(equalToConstant: UIButton.buttonDefaultSize.height*0.66).isActive = true
        }
        
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
        
        addSectionForDevScreen(title: "RJS_Color.Pack1: \(RJS_ColorPack1.allCases.count) values")
        RJS_ColorPack1.allCases.forEach { (some) in
            let reportView = some.reportView
            self.add(some.reportView)
            reportView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        
        addSectionForDevScreen(title: "RJS_Color.Pack2: \(RJS_ColorPack2.allCases.count) values")
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
