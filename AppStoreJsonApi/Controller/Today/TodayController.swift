//
//  TodayController.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 5/9/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class TodayController: BaseCollectionViewController, UIGestureRecognizerDelegate {
    
    private var todayItems = [TodayItem]()
    private var topIPadAppGroup: AppGroupModel?
    private var topFreeAppGroup:AppGroupModel?
    
    private let cellId = "cell_id"
    private let todayMultipleAppCellId = "today_multiple_app_cell_id"
    private let padding: CGFloat  = 30
    private var todayDetailControllerBeganOffset: CGFloat = 0.0
    
    private var topDetailViewConstraint: NSLayoutConstraint?
    private var leftDetailViewConstraint: NSLayoutConstraint?
    private var widthDetailViewConstraint: NSLayoutConstraint?
    private var heightDetailViewConstraint: NSLayoutConstraint?
    
    private var btnClose: UIButton?
    
    private var todayDetailController: TodayDetailFullScreenController?
    private var todayMultipleAppContoller: TodayMultipleAppContoller?
    
    private let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    private var startingFrame: CGRect = .zero
    
    let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .whiteLarge)
        view.color = .darkGray
        view.hidesWhenStopped = true
        view.startAnimating()
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        featchApps()
        setupNavBar()
        setupCollectionView()
    }
    
    private func setupView() {
        setupBlurView()
        view.addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
    }
    
    private func setupNavBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupBlurView() {
        view.addSubview(blurVisualEffectView)
        blurVisualEffectView.fillSuperview()
        blurVisualEffectView.alpha = 0
    }
    
    private func featchApps() {
        
        let dispatchGroup = DispatchGroup()
        
        let topIPad = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-paid/all/50/explicit.json"
        let topFree = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/explicit.json"
        
        dispatchGroup.enter()
        Service.shared.featchAppGroup(urlString: topIPad) { (appGroup, error) in
            self.topIPadAppGroup = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.featchAppGroup(urlString: topFree) { (appGroup, error) in
            self.topFreeAppGroup = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            print("finished featching!")
            self.todayItems = [
                
                TodayItem(category: "LIFE HACK", title: self.topFreeAppGroup?.feed.title ?? "", description: "All apps and tools you need to intelligently organize your life the right way!", image: #imageLiteral(resourceName: "garden"), backgroundColor: .white, cellType: .multiple, apps: self.topFreeAppGroup?.feed.results ?? []),
                
                TodayItem(category: "LIFE HACK", title: "Utilizing your Time", description: "All apps and tools you need to intelligently organize your life the right way!", image: #imageLiteral(resourceName: "garden"), backgroundColor: .white, cellType: .single, apps: []),
                
                TodayItem(category: "DAILY LIST", title:self.topIPadAppGroup?.feed.title ?? "", description: "All apps and tools you need to intelligently organize your life the right way!", image: #imageLiteral(resourceName: "garden"), backgroundColor: .white, cellType: .multiple, apps: self.topIPadAppGroup?.feed.results ?? []),
                
                TodayItem(category: "HOLIDAYS", title: "Travel on a Budget", description: "Find out some description ablout some drazy stuff, so check the link in the description down below!", image: #imageLiteral(resourceName: "holiday"), backgroundColor: #colorLiteral(red: 0.9858620763, green: 0.966611445, blue: 0.7266972661, alpha: 1), cellType: .single, apps: [])
                
            ]
            
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
}

/***********************************************/
/*************** COLLECTION VIEW ***************/
/***********************************************/

extension TodayController {
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        registerCollectionViewCell()
    }
    
    fileprivate func registerCollectionViewCell() {
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMultipleAppCell.self , forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.todayItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        performCollectionViewSelection(collectionView, cell: cell, indexPath: indexPath)
    }
    
    private func performCollectionViewSelection(_ collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath) {
        
        let cellType = self.todayItems[indexPath.item].cellType
        
        if cellType == .multiple {
            let todayMultipleAppContoller = TodayMultipleAppContoller(mode: .fullScreen)
            todayMultipleAppContoller.todayItem = self.todayItems[indexPath.item]
            let navTodayMultipleAppContoller = UINavigationController(rootViewController: todayMultipleAppContoller)
            self.present(navTodayMultipleAppContoller, animated: true)

            return
        }
        
        let todayDetailController = TodayDetailFullScreenController()
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        guard let fullScreenView = todayDetailController.view else { return }
        
        self.todayDetailController = todayDetailController
        self.startingFrame = startingFrame
        
        let todayDetailControllerGesture = UIPanGestureRecognizer(target: self, action: #selector(handleDrag))
        todayDetailControllerGesture.delegate = self
        todayDetailController.view.addGestureRecognizer(todayDetailControllerGesture)
        
        guard let headerCell = todayDetailController.tableView.cellForRow(at: .init(row: 0, section: 0)) as? TodayDetailHeaderCell else { return }
        self.btnClose = headerCell.btnClose
        todayDetailController.todayItem = self.todayItems[indexPath.item]
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        
        fullScreenView.frame = startingFrame
        fullScreenView.layer.cornerRadius = 16
        self.view.addSubview(fullScreenView)
        self.addChild(todayDetailController)
        
        headerCell.handleBtnCloseTapped = { [weak self] in
            guard let self = self else { return }
            self.handleFullscreenViewRemove()
            // hide btn close
            headerCell.btnClose.alpha = 0
        }
        
        self.topDetailViewConstraint = fullScreenView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: startingFrame.origin.y)
        self.leftDetailViewConstraint = fullScreenView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: startingFrame.origin.x)
        self.widthDetailViewConstraint = fullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        self.heightDetailViewConstraint = fullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        
        
        [self.topDetailViewConstraint, self.leftDetailViewConstraint, self.heightDetailViewConstraint, self.widthDetailViewConstraint].forEach({$0?.isActive = true})
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            fullScreenView.frame = self.view.frame
            fullScreenView.layer.cornerRadius = 0
            
            self.topDetailViewConstraint?.constant = 0
            self.leftDetailViewConstraint?.constant = 0
            self.widthDetailViewConstraint?.constant = self.view.frame.width
            self.heightDetailViewConstraint?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            
            headerCell.todayCell.topConstraint?.constant = statusBarHeight + 10
            headerCell.layoutIfNeeded()
            
        })
    }
    
    @objc private func handleFullscreenViewRemove() {
        
        self.collectionView.isUserInteractionEnabled = false
        
        guard let headerCell = self.todayDetailController?.tableView.cellForRow(at: .init(row: 0, section: 0)) as? TodayDetailHeaderCell else { return }
        guard let fullScreenView = self.todayDetailController?.view else { return }
        fullScreenView.layer.cornerRadius = 16
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.blurVisualEffectView.alpha = 0
            self.todayDetailController?.view.transform = .identity
            
            guard let todayDetailController =  self.todayDetailController else { return }
            
            todayDetailController.tableView.contentOffset.y = 0
            
            fullScreenView.translatesAutoresizingMaskIntoConstraints = false
            
            self.topDetailViewConstraint?.constant = self.startingFrame.origin.y
            self.leftDetailViewConstraint?.constant = self.startingFrame.origin.x
            self.widthDetailViewConstraint?.constant = self.startingFrame.width
            self.heightDetailViewConstraint?.constant = self.startingFrame.height
            
            self.view.layoutIfNeeded()
            
            fullScreenView.frame = self.startingFrame
            self.tabBarController?.tabBar.transform = .identity
            
            headerCell.btnClose.alpha = 0
            headerCell.todayCell.topConstraint?.constant = 24
            headerCell.layoutIfNeeded()
            
        }) { _ in
            fullScreenView.removeFromSuperview()
            self.todayDetailController?.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        }
    }
    
    @objc private func handleDrag(gestuer: UIPanGestureRecognizer) {
        
        let translationY = gestuer.translation(in: self.todayDetailController?.view).y
        
        if gestuer.state == .began {
            todayDetailControllerBeganOffset = todayDetailController?.tableView.contentOffset.y ?? 0
        }
        
        if todayDetailController?.tableView.contentOffset.y ?? 0 > 0 { return }
        
        switch gestuer.state {
        case .changed:
            if translationY > 0 {
                let trueOffSet = translationY - todayDetailControllerBeganOffset
                var scale = 1 - trueOffSet / 1000
                
                scale = min(1, scale)
                scale = max(0.75, scale)
                
                blurVisualEffectView.alpha = 1
                todayDetailController?.view.transform = .init(scaleX: scale, y: scale)
                
                self.btnClose?.alpha = 1 - translationY / 250
            }
        case .ended:
            if translationY > 120 {
                handleFullscreenViewRemove()
            } else {
                // back to full size mode
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                   self.todayDetailController?.view.transform = .identity
                    self.btnClose?.alpha = 1
                })
            }
        default:
            ()
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellType = self.todayItems[indexPath.item].cellType.rawValue
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType, for: indexPath) as? BaseTodayCell else { return UICollectionViewCell() }
        
        cell.todayItem = self.todayItems[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - ( 2 * padding), height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
}

