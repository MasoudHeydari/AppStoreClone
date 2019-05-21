//
//  UIButton+Helper.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 4/23/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}
