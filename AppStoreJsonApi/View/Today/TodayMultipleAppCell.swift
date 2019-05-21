//
//  TodayMultipleAppCell.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 5/14/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class TodayMultipleAppCell: BaseTodayCell {
    
    override var todayItem: TodayItem? {
        didSet {
            guard let todayItem = self.todayItem else { return }
            self.multipleAppContoller.todayItem = todayItem
        }
    }
    
    let multipleAppContoller = TodayMultipleAppContoller(mode: .small)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 16
        backgroundColor = .white
        guard let multipleAppContollerView = multipleAppContoller.view else { return }
        addSubview(multipleAppContollerView)
        multipleAppContollerView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
