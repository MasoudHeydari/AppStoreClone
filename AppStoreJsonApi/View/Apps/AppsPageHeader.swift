//
//  AppsPageHeader.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 4/23/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class AppsPageHeader: UICollectionReusableView {
    
    // MARK:- Porperties
    let headerHorizontalController = AppsHeaderHorizontalController()
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        backgroundColor = .white
        guard let headerHorizontalView = self.headerHorizontalController.view else { return }
        addSubview(headerHorizontalView)
        headerHorizontalView.fillSuperview()
    
    }
}
