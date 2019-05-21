//
//  UIImageView+Helper.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 4/23/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.contentMode = .scaleToFill
        self.clipsToBounds = true
    }
}
