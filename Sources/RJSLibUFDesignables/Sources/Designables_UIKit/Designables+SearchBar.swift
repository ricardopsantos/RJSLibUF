//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import Foundation
import UIKit
import Combine
//
import RJSLibUFBase

public extension RJS_Designables_UIKit {
    
    class SearchBar: UISearchBar, UISearchBarDelegate {
        
        weak var searchDelegate: UISearchBarDelegate?
        
        override public func layoutSubviews() {
            super.layoutSubviews()
            setShowsCancelButton(false, animated: false)
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            delegate = self
        }
        
        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)!
            delegate = self
        }
        
        public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            if searchDelegate?.searchBarTextDidBeginEditing != nil {
                searchDelegate?.searchBarTextDidBeginEditing!(searchBar)
            }
            searchBar.setShowsCancelButton(true, animated: true)
        }
        
        public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            if searchDelegate?.searchBarCancelButtonClicked != nil {
                searchDelegate?.searchBarCancelButtonClicked!(searchBar)
            }
            searchBar.setShowsCancelButton(false, animated: true)
            searchBar.resignFirstResponder()
        }
        
        public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            if searchDelegate?.searchBarSearchButtonClicked != nil {
                searchDelegate?.searchBarSearchButtonClicked!(searchBar)
            }
            searchBar.setShowsCancelButton(false, animated: true)
            searchBar.resignFirstResponder()
        }
        
        public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if let textDidChange: (UISearchBar, String) -> Void = searchDelegate?.searchBar {
                textDidChange(searchBar, searchText)
            }
        }
    }
}

public extension RJS_Designables_UIKit {
    
    class SearchTextField: UISearchTextField {
                
        private var cancelBag = CancelBag()
        private var currentValue = CurrentValueSubject<String?, Never>(nil) // Will emit immediately, can hold and relay the latest value subscribers

        public var textValue: String {
            currentValue.value ?? ""
        }
        
        override public func layoutSubviews() {
            super.layoutSubviews()
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupRX()
        }
        
        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)!
            setupRX()
        }
        
        func setupRX() {
            textDidChangePublisher.sink { [weak self] (some) in
                self?.currentValue.send(some)
            }.store(in: cancelBag)
        }
    }
}
#endif
