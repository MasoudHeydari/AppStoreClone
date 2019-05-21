//
//  AppDetailsReviewHorizontalCollectionViewController.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 5/7/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class AppDetailReviewHorizontalCollectionViewController: HorizontalSnappingCollectionViewController {
    
    fileprivate let leftRightPadding: CGFloat = 20.0
    fileprivate let topBottomPadding: CGFloat = 10.0
    
    fileprivate let appDetailReviewHorizontalCollectionViewCellId = "app_detail_review_horizontal_collectionview_cell_id"
    
    var entries: [Entry]? {
        didSet {
            if let entries = self.entries {
                print(entries.forEach({$0.author}))
            }
            self.collectionView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate func setupView() {
        setupCollectionView()
    }
}


/***********************************************/
/*************** COLLECTION VIEW ***************/
/***********************************************/

extension AppDetailReviewHorizontalCollectionViewController {
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(AppDetailReviewHorizontalCell.self, forCellWithReuseIdentifier: appDetailReviewHorizontalCollectionViewCellId)
        
        collectionView.contentInset = .init(top: topBottomPadding, left: leftRightPadding, bottom: topBottomPadding, right: leftRightPadding)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.entries?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appDetailReviewHorizontalCollectionViewCellId, for: indexPath) as! AppDetailReviewHorizontalCell
        cell.entry = self.entries?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - (2 * self.leftRightPadding)
        return .init(width: width, height: view.frame.height - topBottomPadding)
    }
}
