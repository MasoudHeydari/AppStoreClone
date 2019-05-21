//
//  AppsHorizontalController.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 4/22/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class AppsHorizontalController: HorizontalSnappingCollectionViewController {
    
    var feedResults: [FeedResultModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var didSelectHandler: ((FeedResultModel) -> ())?
    var didBtnGETSelectHandler: (() -> ())?
    
    let leftRightPadding: CGFloat = 40
    let topBottomPadding: CGFloat = 10
    let lineSpacing: CGFloat = 13
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
    }
    
    fileprivate func setupView() {
        collectionView.backgroundColor = .white
        view.backgroundColor = .white
    }
}

/***********************************************/
/*************** COLLECTION VIEW ***************/
/***********************************************/

extension AppsHorizontalController {
    
    fileprivate func setupCollectionView() {
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: Const.ID.Cell.appsGroupHorizontal)
        
        // cahnge the direction of collection view
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.scrollDirection = .horizontal
        
        collectionView.contentInset = .init(top: topBottomPadding, left: leftRightPadding / 2, bottom: topBottomPadding, right: leftRightPadding / 2)


    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.feedResults?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let feedResult = self.feedResults?[indexPath.item] else { return }
        self.didSelectHandler?(feedResult)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var index = indexPath
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.ID.Cell.appsGroupHorizontal, for: index) as! AppRowCell
        
        cell.appFeedResult = self.feedResults?[index.item]
        cell.btnGetSelectHandler = didBtnGETSelectHandler
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - 2 * topBottomPadding - 2 * lineSpacing) / 3
        return .init(width: view.frame.width - leftRightPadding , height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
}
