//
//  HeaderMultipleAppCell.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 5/17/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class HeaderMultipleAppCell: UICollectionReusableView {
    
    var todayItem: TodayItem? {
        didSet {
            guard let todayItem = self.todayItem else { return }
            self.categoryLabel.text = todayItem.category
            self.titleLabel.text = todayItem.title
        }
    }
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "LIFE HACK"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Utilize Your Life With some..."
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.numberOfLines = 2
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        let stackView = VerticalStackView(subviews: [
            categoryLabel, titleLabel, UIView()
            ], spacing: 12)
        
        addSubview(stackView)
        stackView.fillSuperview()
        
    }
}
