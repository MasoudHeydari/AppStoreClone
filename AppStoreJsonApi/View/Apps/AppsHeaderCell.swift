//
//  AppsHeaderCell.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 4/23/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
    
    var socialApp: SocialApp? {
        didSet {
            guard let socialApp = self.socialApp else { return }
            self.companyLabel.text = socialApp.name
            self.titleLabel.text = socialApp.tagline
            self.imageView.sd_setImage(with: URL(string: socialApp.imageUrl))
        }
    }
    
    let companyLabel: UILabel = {
        let label = UILabel(text: "FACEBOOK", font: .boldSystemFont(ofSize: 12))
        label.sizeToFit()
        label.textColor = .purple
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(text: "Keeping Up with Your Friends is Faster Than Ever", font: .systemFont(ofSize: 22))
        label.numberOfLines = 2
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        backgroundColor = .white
        
        let imageViewHeight: CGFloat = frame.width * (0.5652)
        self.imageView.constrainHeight(constant: imageViewHeight)
        
        let stackView = VerticalStackView(subviews: [
            companyLabel, titleLabel, imageView], spacing: 8)
        stackView.alignment = .top
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 12, left: 0, bottom: 0, right: 0))
    }
}
