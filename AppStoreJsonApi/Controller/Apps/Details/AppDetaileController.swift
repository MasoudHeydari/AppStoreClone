//
//  AppDetaileController.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 5/2/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class AppDetailController: BaseCollectionViewController {
    
    private let appDetailCellId = "app_cell_id"
    private let appDetailPreviewCellId = "app_detail_preview_cell_id"
    private let appDetailReviewCellId = "app_detail_Review_cell_id"
    
    private var lastContentOffset: CGFloat = 0.0
    
    private var result: Result?
    private var reviews: Reviews?
    private var numOfCells: Int?
    private var cellSize: CGSize?
    
    private var iconAndNameLabelStackView: UIStackView?
    private var isTopViewShowing = true
    
    let splashView: SplashView = {
        let view = SplashView()
        return view
    }()
    
    private var appId: String
    
    public init(appId: String) {
        self.appId = appId
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featchData()
        setupSplashView()
        setup()
        setupNavBar()
        
    }
    
    fileprivate func setup() {
        self.splashView.stopAnim()
        setupCollectionView()
    }
    
    fileprivate func setupSplashView() {
        view.addSubview(splashView)
        splashView.fillSuperview()
        splashView.startAnim()
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: appDetailCellId)
        collectionView.register(AppDetailPreviewCell.self, forCellWithReuseIdentifier: appDetailPreviewCellId)
        collectionView.register(AppDetailReviewCell.self, forCellWithReuseIdentifier: appDetailReviewCellId)
    }
    
    private func setupNavBar() {
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.shadowImage = UIImage()

    }
    
    private func featchData() {
        
        let urlString = "https://itunes.apple.com/lookup?id=\(appId)"
        Service.shared.featchGenericJSONData(urlString: urlString) { (result: SearchResultModel?, error) in
            guard let result = result else { return }
            self.result = result.results.first
            
            DispatchQueue.main.async {
                _ = self.getScreenshotImageSize(urlString: result.results[0].screenshotUrls[0])
                self.numOfCells = 3
                self.collectionView.reloadData()
            }
        }
        
        // parse reviews data
        let reviewUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId)/sortby=mostrecent/json?l=en&&cc=us"
        print("url \(reviewUrl)")
        Service.shared.featchGenericJSONData(urlString: reviewUrl) { (reviews: Reviews?, err) in
            if let err = err {
                print("there are some error while parsing REVIEWS: ", err)
            }
            
            guard let reviews = reviews else { return }
            self.reviews = reviews
            
            // should i reload the collectionview ???
        }
    }
    
    fileprivate func getScreenshotImageSize(urlString: String) -> CGSize {
        var size: CGSize = .zero
        
        let dispathGroup = DispatchGroup()
        dispathGroup.enter()
        
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            if let imageData = data {
                let image = UIImage(data: imageData)
                size = image?.size ?? .zero
                dispathGroup.leave()
            }
            }.resume()
        
        dispathGroup.notify(queue: .main) {
            print("image downloaded completely! size:  \(size)")
            self.cellSize = size
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
        
        return size
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // disable 'preferedLargeTitles' mode for this specific ViewController - added by: Masoud Heydari  -  2 May 2019  23:33
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func willMove(toParent parent: UIViewController?) {
        // this method get called when user tap on back button or drage to left to back to previoce viewcontroller. added by; Masoud Heydari - 2 May 2019  23:44
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

/***********************************************/
/*************** COLLECTION VIEW ***************/
/***********************************************/

extension AppDetailController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numOfCells ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let result = self.result else { return UICollectionViewCell() }
        
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appDetailCellId, for: indexPath) as! AppDetailCell
            cell.layoutIfNeeded()
            cell.result = result
            
            cell.btnGetDidSelect = {
                self.btnGetDidSelect()
            }
            
            self.iconAndNameLabelStackView = cell.iconAndNameLabelStackView
            
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appDetailPreviewCellId, for: indexPath) as! AppDetailPreviewCell
            cell.screenShotController.screenShotUrls = result.screenshotUrls
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appDetailReviewCellId, for: indexPath) as! AppDetailReviewCell
            cell.backgroundColor = .white
            cell.appDetailPreviewHorizontalController.entries = self.reviews?.feed.entry
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 280.0
        
        switch indexPath.item {
        case 0:
            let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.releaseNoteLabel.text = self.result?.releaseNotes
            dummyCell.layoutIfNeeded()
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            
            height = estimatedSize.height
            
        case 1:
            height = calculatefinalPreviewCellSize().height
        case 2:
            height = 300
        default:
            height = 0.0
        }
        
        return .init(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 16, right: 0)
    }
    
    private func calculatefinalPreviewCellSize() -> CGSize {
        let previewLabel = UILabel()
        previewLabel.text = "Preview"
        previewLabel.font = .boldSystemFont(ofSize: 20)
        previewLabel.sizeToFit()
        
        let previewLabelSize = previewLabel.bounds.size
        
        var finalCellSize: CGSize = .zero
        if Int(self.cellSize?.height ?? 0) > Int(self.cellSize?.width ?? 0) {
            finalCellSize.width = self.view.frame.width
            finalCellSize.height = ((self.view.frame.width * 2 / 3 ) * 1.78 ) + (previewLabelSize.height * 3 / 2)
        } else if Int(self.cellSize?.height ?? 0) < Int(self.cellSize?.width ?? 0) {
            finalCellSize.width = self.view.frame.width
            finalCellSize.height = ((self.view.frame.width - 40) * 0.5652 ) + (previewLabelSize.height * 3 / 2)
        }
        
        return finalCellSize
    }
    
    private func btnGetDidSelect() {
        print("btn get did selected!")
    }
}

/*******************************************/
/*************** SCROLL VIEW ***************/
/*******************************************/

extension AppDetailController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset < scrollView.contentOffset.y) {
            // did move up
            if 50 < scrollView.contentOffset.y && isTopViewShowing {
                showElementsInNavBar()
            }
        } else if (self.lastContentOffset > scrollView.contentOffset.y) {
            // did move down
            if 50 > scrollView.contentOffset.y && !isTopViewShowing {
                hideElementsInNavBar()
            }
        } else {
            // didn't move
        }
        
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    private func showElementsInNavBar() {
        print("hidded!")
        isTopViewShowing = false
        
        let imageView = setupNavBarImageView()
        
        guard let iconAndNameLabelStackView = self.iconAndNameLabelStackView else { return }
        
        imageView.sd_setImage(with: URL(string: self.result?.artworkUrl100 ?? ""))
        navigationItem.titleView = imageView
        
        let rightNavBarCustomView = setupNavRightBarButtonItem()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightNavBarCustomView)
        guard let customView = self.navigationItem.rightBarButtonItem?.customView else { return }
        
        navigationItem.titleView?.transform = CGAffineTransform(translationX: 0, y: 15)
        customView.transform = CGAffineTransform(translationX: 0, y: 15)
        
        customView.alpha = 0
        
        UIView.animate(withDuration: 0.2) {
            self.navigationItem.titleView?.transform = .identity
            imageView.alpha = 1
            
            customView.transform = .identity
            customView.alpha = 1
            
            iconAndNameLabelStackView.alpha = 0
        }
        
    }
    
    private func hideElementsInNavBar() {
        print("showed!")
        guard let iconAndNameLabelStackView = self.iconAndNameLabelStackView else { return }
        isTopViewShowing = true
        
        UIView.animate(withDuration: 0.2, animations: {
            iconAndNameLabelStackView.alpha = 1
            
            self.navigationItem.titleView?.transform = CGAffineTransform(translationX: 0, y: 15)
            self.navigationItem.titleView?.alpha = 0
            
            guard let customView = self.navigationItem.rightBarButtonItem?.customView else { return }
            customView.transform = CGAffineTransform(translationX: 0, y: 15)
            customView.alpha = 0
            
        }) { (_) in
            self.navigationItem.titleView = nil
            self.navigationItem.rightBarButtonItem?.customView = nil
        }
    }
    
    private func setupNavBarImageView() -> UIImageView {
        let imageView = CustomImageView()
        imageView.constrainWidth(constant: 40)
        imageView.constrainHeight(constant: 40)
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 0.5
        return imageView
    }
    
    private func setupNavRightBarButtonItem() -> UIButton {
        let btn = UIButton(type: .system)
        btn.constrainHeight(constant: 32)
        btn.constrainWidth(constant: 80)
        btn.backgroundColor = UIColor(red: 45/255, green: 108/255, blue: 241/255, alpha: 1)
        btn.setTitle(self.result?.formattedPrice ?? "", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.layer.cornerRadius = 16
        btn.addTarget(self, action: #selector(handleBtnGettapped(_:)), for: .touchUpInside)
        return btn
    }
    
    @objc private func handleBtnGettapped(_ sender: UIButton) {
        self.btnGetDidSelect()
    }
}

class CustomImageView: UIImageView {
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
}
