//
//  BackEnabledNavigationController.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 5/15/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class BackEnabledNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1
    }

}
