//
//  HorizontalSnapingCollectionViewController.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 5/3/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//
import UIKit

class HorizontalSnappingCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    init() {
        let layout = BetterSnappingLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
