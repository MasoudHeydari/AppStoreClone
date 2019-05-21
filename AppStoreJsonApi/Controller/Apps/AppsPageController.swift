//
//  AppsController.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 4/22/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class AppsPageController: BaseCollectionViewController {
    
    var appGroups = [AppGroupModel]()
    
    let splashView: SplashView = {
        let sv = SplashView()
        return sv
    }()
    
    // MARK:- Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSplashView()
        featchData()
        setupView()
        setupCollectionView()
    }
    
    fileprivate func setupView() {
        collectionView.backgroundColor = .white
    }
    
    fileprivate func setupSplashView() {
        view.addSubview(splashView)
        splashView.fillSuperview()
        splashView.startAnim()
    }
    
    fileprivate func featchData() {
        Service.shared.featchGames { (appGroups, errs) in
            
            if errs.count != 0 {
                print("there are some error")
                return
            }
            
//            if errs[0].
            
            self.appGroups = appGroups
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.splashView.stopAnim()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}


/***********************************************/
/*************** COLLECTION VIEW ***************/
/***********************************************/

extension AppsPageController {
    
    fileprivate func setupCollectionView() {
        collectionView.alwaysBounceVertical = false
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: Const.ID.Cell.apps)
        // register header for apps page controller. added by: Masoud Heydari -> 23 April 2019 - 17:09
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Const.ID.Cell.appsPageHeader)

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.appGroups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Const.ID.Cell.appsPageHeader, for: indexPath) as! AppsPageHeader
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.ID.Cell.apps, for: indexPath) as! AppsGroupCell
        cell.feed = appGroups[indexPath.item].feed
        cell.horizontalController.didSelectHandler = { [weak self] feedResult in
            guard let strongSlef = self else { return }
            let appId = feedResult.id
            let appDetailController = AppDetailController(appId: appId)
            strongSlef.navigationController?.pushViewController(appDetailController, animated: true)
        }
        
        cell.horizontalController.didBtnGETSelectHandler = {
            // do what you want when user tapped on 'btnGET'
            print("Btn GET Tapped!")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let dummyCell = AppsHeaderCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000.0))
        dummyCell.layoutIfNeeded()
        let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000.0))
        
        
        return .init(width: view.frame.width, height: estimatedSize.height - 18)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
}
