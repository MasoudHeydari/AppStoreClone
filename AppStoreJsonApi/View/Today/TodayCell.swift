//
//  TodayCell.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 5/9/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class TodayCell: BaseTodayCell {
    
    // MARK:- Properties
    
    override var todayItem: TodayItem? {
        didSet {
            guard let todayItem = self.todayItem else { return }
            self.categoryLabel.text = todayItem.category
            self.titleLabel.text = todayItem.title
            self.descriptionLabel.text = todayItem.description
            self.image.image = todayItem.image
            self.backgroundView?.backgroundColor = todayItem.backgroundColor
        }
    }
    
    var topConstraint: NSLayoutConstraint?
    
    let image: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "garden"))
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.numberOfLines = 1
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        layer.cornerRadius = 16
//        clipsToBounds = true
        
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(categoryLabel)
        
        let imageContainerView = UIView()
        imageContainerView.addSubview(image)
        image.clipsToBounds = true
        image.centerInSuperview(size: .init(width: 200, height: 200))
        
        let stackView = VerticalStackView(subviews: [
            categoryLabel,
            titleLabel,
            imageContainerView,
            descriptionLabel
            ], spacing: 8)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        self.topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24).isActive = true
        
        self.topConstraint?.isActive = true
        
        
    }
}
