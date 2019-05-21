//
//  BaseTodayCell.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 5/14/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class BaseTodayCell: UICollectionViewCell {
    
    var todayItem: TodayItem?
    
    override var isHighlighted: Bool {
        didSet {
            
            var transform: CGAffineTransform = .identity

            if isHighlighted {
                transform = .init(scaleX: 0.9, y: 0.9)
            }
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.transform = transform
            })
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupShdowCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public final func setupShdowCell() {
        self.backgroundView = UIView()
        guard let backgroundView = self.backgroundView else { return }
        
        addSubview(backgroundView)
        backgroundView.backgroundColor = .white
        backgroundView.fillSuperview()
        
        backgroundView.layer.shadowOffset = .init(width: 0, height: 10)
        backgroundView.layer.shadowOpacity = 0.1
        backgroundView.layer.shadowRadius = 10
        backgroundView.layer.shouldRasterize = true
        backgroundView.layer.cornerRadius = 16
    }
    
    
}
