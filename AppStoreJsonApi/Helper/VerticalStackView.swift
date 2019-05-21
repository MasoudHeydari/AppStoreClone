//
//  VerticalStackView.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 4/19/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class VerticalStackView: UIStackView {
     public init(subviews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        self.spacing = spacing
        self.axis = .vertical
        subviews.forEach({addArrangedSubview($0)})
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension UIStackView {
    
    convenience init(subviews: [UIView], customSpacing: CGFloat) {
        self.init(arrangedSubviews: subviews)
        self.spacing = customSpacing
    }
}
