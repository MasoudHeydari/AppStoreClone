//
//  AppDetailPreviewCollectionViewController.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 5/3/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class AppDetailScreenShotCollectionViewController: HorizontalSnappingCollectionViewController {
    
    fileprivate let leftRightPadding: CGFloat = 20.0
    
    let addDetailScreenShotCellId = "add_detail_screenshot_cell_id"
    var cellSize: CGSize?
    
    var screenShotUrls: [String]? {
        didSet {
            if let screenShotUrls = screenShotUrls {
                self.screenShotUrls = screenShotUrls
                self.collectionView.reloadData()
                _ = self.getScreenshotImageSize(urlString: screenShotUrls[0])
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    fileprivate func getScreenshotImageSize(urlString: String) -> CGSize {
        var size: CGSize = .zero
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            if let imageData = data {
                let image = UIImage(data: imageData)
                size = image?.size ?? .zero
                dispatchGroup.leave()
            }
            }.resume()
        
        dispatchGroup.notify(queue: .main) {
            print("image downloaded completely! size:  \(size)")
            self.cellSize = size
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
        
        return size
    }
}

/***********************************************/
/*************** COLLECTION VIEW ***************/
/***********************************************/
extension AppDetailScreenShotCollectionViewController {
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(AppDetailScreenShotCell.self, forCellWithReuseIdentifier: addDetailScreenShotCellId)
        collectionView.contentInset = .init(top: 0, left: leftRightPadding, bottom: 0, right: leftRightPadding)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.screenShotUrls?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addDetailScreenShotCellId, for: indexPath) as! AppDetailScreenShotCell
        cell.screenShotUrl = self.screenShotUrls?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return calculatefinalCellSize()
    }
    
    fileprivate func calculatefinalCellSize() -> CGSize {
        
        var finalCellSize: CGSize = .zero
        if Int(self.cellSize?.height ?? 0) > Int(self.cellSize?.width ?? 0) {
            finalCellSize.width = (self.view.frame.width * 2 / 3 )
            finalCellSize.height = (self.view.frame.width * 2 / 3 ) * 1.78
        } else if Int(self.cellSize?.height ?? 0) < Int(self.cellSize?.width ?? 0) {
            finalCellSize.width = self.view.frame.width - (2 * leftRightPadding)
            finalCellSize.height = (self.view.frame.width - (2 * leftRightPadding)) * 0.5652
        }
        
        return finalCellSize
    }
    
    
}

