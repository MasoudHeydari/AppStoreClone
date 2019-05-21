//
//  AppsGroupCell.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 4/22/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {
    
    var feed: FeedModel? {
        didSet {
            if let feed = feed {
                self.titleLabel.text = feed.title
                self.horizontalController.feedResults = feed.results
            }
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "App Section"
        label.backgroundColor = .white
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    let horizontalController = AppsHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        addViews()
        addViewsConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        backgroundColor = .white
    }
    
    fileprivate func addViews() {
        addSubview(titleLabel)
        
        addSubview(horizontalController.view)
    }
    
    fileprivate func addViewsConstraints() {
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0) )

        let horizontalControllerView = self.horizontalController.view!
        horizontalControllerView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
}
