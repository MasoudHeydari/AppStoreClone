//
//  UIViewControlelr+Helper.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 5/7/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

extension UIViewController {
    var navBarHeight: CGFloat {
        return  UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
}
