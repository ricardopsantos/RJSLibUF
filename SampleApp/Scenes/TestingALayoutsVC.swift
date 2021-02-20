//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import UIKit
import LocalAuthentication
//
import RJSLibUFBase
import RJSLibUFStorage
import RJSLibUFNetworking
import RJSLibUFALayouts
import RJSLibUFAppThemes

//
// RJSLibUFALayouts was deprecated on 2021 Jan and its not mantained anymore
// RJSLibUFALayouts was deprecated on 2021 Jan and its not mantained anymore
// RJSLibUFALayouts was deprecated on 2021 Jan and its not mantained anymore
//

struct Source1 {
    let title: String
}

class TestingALayoutsVC: GenericViewController {

    var viewWidthConstraint: NSLayoutConstraint!
    var viewMarginTopConstraint: NSLayoutConstraint!

    private lazy var collectionView1: UICollectionView = {
        let itemSizeK: CGFloat = 0.8
        let itemSize: CGSize = CGSize(width: (screenWidth*0.8), height: (screenHeight/2)*itemSizeK)
        let some = RJS_UIKitFactory.collectionView(baseController: self, itemSize: itemSize, direction: .horizontal)
        some.backgroundColor = UIColor.random
        some.rjsALayouts.setMargin(0, on: .top)
        some.rjsALayouts.setMargin(0, on: .left)
        some.rjsALayouts.setMargin(0, on: .right)
        some.rjsALayouts.setHeight(screenHeight/4)
        return some
    }()

    private lazy var viewChangingWidth: UIView = {
        let some = UIView()
        view.addSubview(some)
        some.backgroundColor = UIColor.random
        some.rjsALayouts.setSame(.centerX, as: view, method: .constraints)
        viewMarginTopConstraint = some.rjsALayouts.setMargin(10, on: .top, method: .constraints)
        viewWidthConstraint     = some.rjsALayouts.setValue(screenWidth * 0.8, for: .width, method: .constraints)
        some.rjsALayouts.setHeight(200)
        some.backgroundColor = .yellow
        return some
    }()

    private lazy var collectionView2: UICollectionView = {
        let itemSizeK: CGFloat = 0.8
        let itemSize: CGSize = CGSize(width: (screenWidth/2)*itemSizeK, height: (screenHeight/2)*itemSizeK)
        let some = RJS_UIKitFactory.collectionView(baseController: self, itemSize: itemSize, direction: .vertical)
        some.backgroundColor = UIColor.random
        some.rjsALayouts.setMargin(0, on: .top, from: collectionView1)
        some.rjsALayouts.setMargin(0, on: .left)
        some.rjsALayouts.setMargin(0, on: .right)
        let overlap: CGFloat = 0//V.BottomBar.defaultHeight() - V.BottomBar.backgroundHeight()
        some.rjsALayouts.setMargin(overlap, on: .bottom)
        return some
    }()

    private lazy var lbl1: UILabel = {
        let label = UILabel()
        view.addSubview(label)
        label.backgroundColor = UIColor.random
        label.rjsALayouts.setMargin(50, on: .top)
        label.rjsALayouts.setMargin(50, on: .left)
        label.rjsALayouts.setHeight(50)
        let imageView = RJS_UIKitFactory.imageView(urlString: "https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Google_Images_2015_logo.svg/1200px-Google_Images_2015_logo.svg.png")
        view.addSubview(imageView)
        imageView.rjsALayouts.setMargin(50, on: .top)
        imageView.rjsALayouts.setMargin(50, on: .left, from: label)
        imageView.rjsALayouts.setHeight(50)
        return label
    }()
    
    override func loadView() {
        super.loadView()
        prepareLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        RJS_ColdCache.shared.printReport()

        let key = "LoginCount"
        if let loginsCount = RJS_StorableKeyValue.with(key: key) {
            RJS_Logs.info(loginsCount, tag: .rjsLib)
            if let recordValue = loginsCount.value, let loginsCount =  Int(recordValue) {
                _ = RJS_StorableKeyValue.save(key: key, value: "\(loginsCount+1)")
            }
        } else {
            _ = RJS_StorableKeyValue.save(key: key, value: "0")
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func prepareLayout() {
        view.backgroundColor = .white
        collectionView1.lazyLoad()
        collectionView2.lazyLoad()
    }
}

// MARK: - View Protocol

extension TestingALayoutsVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    var dataSource1: [Source1] {
        return [Source1(title: "1.1"),
                Source1(title: "1.2"),
                Source1(title: "1.3")
        ]
    }
    
    var dataSource2: [Source1] {
        return [Source1(title: "2.1"),
                Source1(title: "2.2"),
                Source1(title: "2.3"),
                Source1(title: "2.4"),
                Source1(title: "2.5"),
                Source1(title: "2.6")
        ]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView1 {
            return dataSource1.count
        } else {
            return dataSource2.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionView1 {
            let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: RJS_Constants.cellIdentifier, for: indexPath as IndexPath)
            myCell.backgroundColor = UIColor.blue
            let item = dataSource1[indexPath.row]
            _ = myCell.subviews.map { $0.removeFromSuperview() }
            let label = RJS_UIKitFactory.label(title: item.title, style: .value)
            label.textAlignment = .center
            myCell.addSubview(label)
            label.rjsALayouts.setMargin(0, on: .top)
            label.rjsALayouts.setMargin(0, on: .left)
            label.rjsALayouts.setMargin(0, on: .bottom)
            label.rjsALayouts.setMargin(0, on: .right)
            return myCell
        } else {
            let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: RJS_Constants.cellIdentifier, for: indexPath as IndexPath)
            myCell.backgroundColor = UIColor.blue
            let item = dataSource2[indexPath.row]
            _ = myCell.subviews.map { $0.removeFromSuperview() }
            let label = RJS_UIKitFactory.label(title: item.title, style: .value)
            label.textAlignment = .center
            myCell.addSubview(label)
            label.rjsALayouts.setMargin(0, on: .top)
            label.rjsALayouts.setMargin(0, on: .left)
            label.rjsALayouts.setMargin(0, on: .bottom)
            label.rjsALayouts.setMargin(0, on: .right)
            return myCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        RJS_Logs.info("User tapped on item \(indexPath.row)", tag: .client)
    }
    
}
