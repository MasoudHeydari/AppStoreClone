//
//  TodayItem.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 5/11/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

struct TodayItem {
    let category: String
    let title: String
    let description: String
    let image: UIImage
    let backgroundColor: UIColor
    let cellType: CellType
    let apps: [FeedResultModel]
    
    enum CellType: String {
        case single, multiple
    }
}
