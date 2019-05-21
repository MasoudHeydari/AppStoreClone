//
//  SplashView.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 4/30/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

enum SplashViewSize {
    case large
    case small
}

class SplashView: UIView {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .gray)
        return ai
    }()
    
    let btnRetry: UIButton = {
        let btn = UIButton(type: .custom)
        btn.constrainWidth(constant: 200)
        btn.constrainHeight(constant: 48)
        
        btn.setTitleColor(.lightGray, for: .normal)
        btn.setTitleColor(.darkGray, for: .highlighted)
        
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.setTitle("Retry", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.layer.borderWidth = 0.5
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public init(size: SplashViewSize = .small) {
        super.init(frame: .zero)
        //
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        backgroundColor = .white
        self.addSubview(activityIndicator)
//        self.addSubview(btnRetry)
        
        activityIndicator.center = self.center
        activityIndicator.fillSuperview()
        
//        btnRetry.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        btnRetry.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    public func startAnim() {
        self.activityIndicator.startAnimating()
    }
    
    public func stopAnim() {
        activityIndicator.stopAnimating()
        self.removeFromSuperview()
    }
}
