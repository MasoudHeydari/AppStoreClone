//
//  AppDetailReviewCell.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 5/7/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class AppDetailReviewCell: UICollectionViewCell {
    
    let reviewAndRatingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "     Preview & Rating"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let appDetailPreviewHorizontalController = AppDetailReviewHorizontalCollectionViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        backgroundColor = .white
        guard let previewHorizontalView = self.appDetailPreviewHorizontalController.view else { return }
        previewHorizontalView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(previewHorizontalView)
        addSubview(reviewAndRatingLabel)
        
        reviewAndRatingLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        reviewAndRatingLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        reviewAndRatingLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        previewHorizontalView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        previewHorizontalView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        previewHorizontalView.topAnchor.constraint(equalTo: reviewAndRatingLabel.bottomAnchor, constant: 6).isActive = true
        previewHorizontalView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
}
