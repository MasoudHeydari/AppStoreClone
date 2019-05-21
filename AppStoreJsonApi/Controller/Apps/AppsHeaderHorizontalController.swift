//
//  AppsHeaderHorizontalController.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 4/23/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class AppsHeaderHorizontalController: HorizontalSnappingCollectionViewController {
    var socialApps = [SocialApp]()
    
    private let leftRightPadding: CGFloat = 40
    private let topBottomPadding: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featchSocialApp()
        setupView()
        setupCollectionView()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .purple
    }
    
    fileprivate func featchSocialApp() {
        Service.shared.featchSocialApp { (socialApps, error) in
            if let error = error {
                print("there are some error -> Error is: \(error)")
                return
            }
            guard let socialApps = socialApps else { return }
            self.socialApps = socialApps
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}


/***********************************************/
/*************** COLLECTION VIEW ***************/
/***********************************************/

extension AppsHeaderHorizontalController {
    
    fileprivate func setupCollectionView() {
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: Const.ID.Cell.appsPageHeaderHorizontal)
        
        // change direction of collection view to horizontal. added by: Masoud Heydari -> 23 April 2019 - 17:45
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.scrollDirection = .horizontal
        
        collectionView.contentInset = .init(top: topBottomPadding, left: leftRightPadding / 2, bottom: topBottomPadding, right: leftRightPadding / 2)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.socialApps.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.ID.Cell.appsPageHeaderHorizontal, for: indexPath) as? AppsHeaderCell else { return UICollectionViewCell() }
        cell.socialApp = self.socialApps[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - leftRightPadding, height: view.frame.height)
    }
}

