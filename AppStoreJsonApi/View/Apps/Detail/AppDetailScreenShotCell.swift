//
//  AppDetailPreviewCell.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 5/3/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class AppDetailScreenShotCell: UICollectionViewCell {
    
    var screenShotUrl: String? {
        didSet {
            if let screenShotUrl = self.screenShotUrl {
                self.imageView.sd_setImage(with: URL(string: screenShotUrl))
            }
        }
    }
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor(white: 0.95, alpha: 1)
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        image.layer.borderWidth = 1
        return image
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        addSubview(imageView)
        imageView.fillSuperview()
    }
}
