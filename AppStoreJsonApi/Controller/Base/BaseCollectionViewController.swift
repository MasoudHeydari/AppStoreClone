//
//  BaseCollectionViewController.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 4/22/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class BaseCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK:- Init
    
    public init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
