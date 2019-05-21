//
//  TodayMultipleAppContoller.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 5/14/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class TodayMultipleAppContoller: BaseCollectionViewController {
    enum Mode {
        case small, fullScreen
    }
    
    let mode: Mode
    
    private let headerCellId = "header_cell_id"
    private let multipleAppCellId = "multiple_app_cell_id"
    private let lineSpacing: CGFloat = 15
    private let leftRightPadding: CGFloat = 24
    
    var todayItem: TodayItem? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    
    let btnClose: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        btn.tintColor = .darkGray
        return btn
    }()
    
    //    override var prefersStatusBarHidden: Bool { return true }
    
    public init(mode: Mode) {
        self.mode = mode
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        registerCollectionViewCell()
        setupBtnClose()
        
    }
    
    private func setupBtnClose() {
        
        if mode == .fullScreen {
            btnClose.addTarget(self, action: #selector(btnCloseTapped(_:)), for: .touchUpInside)
            view.addSubview(btnClose)
            btnClose.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8).isActive = true
            btnClose.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.statusBarHeight).isActive = true
            btnClose.heightAnchor.constraint(equalToConstant: 48).isActive = true
            btnClose.widthAnchor.constraint(equalToConstant: 48).isActive = true
        }
    }
    
    @objc private func btnCloseTapped(_ sender: UIButton) {
        print("btn tapped closed!")
        dismiss(animated: true)
    }
}

/***********************************************/
/*************** COLLECTION VIEW ***************/
/***********************************************/

extension TodayMultipleAppContoller {
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        if mode == .small {
            collectionView.isScrollEnabled = false
            collectionView.isUserInteractionEnabled = false
        } else {
            collectionView.contentInset = .init(top: 12, left: leftRightPadding, bottom: 12, right: leftRightPadding)
            collectionView.isUserInteractionEnabled = true
            
        }
    }
    
    fileprivate func registerCollectionViewCell() {
        collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: multipleAppCellId)
        collectionView.register(HeaderMultipleAppCell.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: headerCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellId, for: indexPath) as? HeaderMultipleAppCell else { return UICollectionReusableView() }
        
        headerView.todayItem = self.todayItem
        return headerView
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 80)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mode == .small ? 4 : todayItem?.apps.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: multipleAppCellId, for: indexPath) as? MultipleAppCell else { return UICollectionViewCell() }
        
        cell.appFeedResult = self.todayItem?.apps[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let appId = self.todayItem?.apps[indexPath.item].id else { return }
        let detailAppController = AppDetailController(appId: appId)
        navigationController?.pushViewController(detailAppController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //        let height: CGFloat = (view.frame.width - ( 3 * lineSpacing)) / 4
        //        print("height \(height)")
        
        if mode == .fullScreen {
            let height: CGFloat = 90
            return .init(width: view.frame.width - 2 * leftRightPadding, height: height)
        }
        
        let height: CGFloat = 60
        return .init(width: view.frame.width, height: height)
    }
    
}


