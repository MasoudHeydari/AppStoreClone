//
//  AppDetailReviewHorizontalCell.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 5/7/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class AppDetailReviewHorizontalCell: UICollectionViewCell {
    
    var entry: Entry? {
        didSet {
            if let entry = entry {
                self.titleLabel.text = entry.title.label
                self.autherLabel.text = entry.author.name.label
                self.commentLabel.text = entry.content.label
                
                for (index, view) in self.starsStackView.arrangedSubviews.enumerated() {
                    if let ratingInt = Int(entry.rating.label) {
                        view.alpha = index >= ratingInt ? 0 : 1
                    }
                }
            }
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title Label"
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let autherLabel: UILabel = {
        let label = UILabel()
        label.text = "Auther Label"
        label.textColor = .gray
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let starsStackView: UIStackView = {
        var arrangesubViews = [UIView]()
        (0..<5).forEach({ (_) in
            let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
            imageView.constrainWidth(constant: 24)
            imageView.constrainHeight(constant: 24)
            arrangesubViews.append(imageView)
        })
        
        arrangesubViews.append(UIView())
        
        let stackView = UIStackView(arrangedSubviews: arrangesubViews)
        return stackView
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "some comment from \nsome crazy boys \nfrom all over the world!\n Label"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 247/255, alpha: 1)
        
        let titleAndAutherStackView = UIStackView(subviews: [titleLabel, UIView(), autherLabel], customSpacing: 8)
        
        let overallStackView = VerticalStackView(subviews: [titleAndAutherStackView, starsStackView, commentLabel, UIView()], spacing: 12)
        
        titleLabel.setContentCompressionResistancePriority(.init(rawValue: 0), for: .horizontal)
        autherLabel.textAlignment = .right
        
        layer.cornerRadius = 12
        
        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
        
        
        
    }
    
    
}
