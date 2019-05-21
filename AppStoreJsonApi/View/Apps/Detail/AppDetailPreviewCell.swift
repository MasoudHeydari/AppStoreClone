//
//  AppDetailPreviewCell.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 5/3/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class AppDetailPreviewCell: UICollectionViewCell {
    
    let previewLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "      Preview"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.sizeToFit()
        return label
    }()
    
    let screenShotController = AppDetailScreenShotCollectionViewController()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        guard let screenShotView = self.screenShotController.view else { return }
        
        addSubview(previewLabel)
        addSubview(screenShotView)
        
        previewLabel.translatesAutoresizingMaskIntoConstraints = false
        screenShotView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let screenShotView = self.screenShotController.view else { return }

        previewLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        previewLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        previewLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        screenShotView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        screenShotView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        screenShotView.topAnchor.constraint(equalTo: previewLabel.bottomAnchor).isActive = true
        screenShotView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

