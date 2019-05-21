//
//  SearchResultCell.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 4/19/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    // MARK:- Properties
    
    var handleBtnGetSelected: (() -> ())?
    
    var appResult: Result! {
        didSet {
            let screenShots = appResult.screenshotUrls.count
            appNameLabel.text = appResult.trackName
            categoryLabel.text = appResult.primaryGenreName
            ratingsLabel.text = "\(appResult.averageUserRating ?? 0) M"
            appIconImageView.sd_setImage(with: URL(string: appResult.artworkUrl100)!)
            
            screenshot1.sd_setImage(with: URL(string: appResult.screenshotUrls[0]))
            
            if screenShots > 1 {
                screenshot2.sd_setImage(with: URL(string: appResult.screenshotUrls[1]))
            }
            
            if screenShots > 2 {
                screenshot3.sd_setImage(with: URL(string: appResult.screenshotUrls[2]))
            }
            
        }
    }
    
    let appIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor(white: 0.9, alpha: 1)
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 16
        iv.clipsToBounds = true
        return iv
    }()
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "APP NAME"
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photo & Video"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.textColor =  UIColor(white: 0.5, alpha: 1)
        label.font = .systemFont(ofSize: 14)
        label.text = "9.2M"
        return label
    }()
    
    let btnGet: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("GET", for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        btn.layer.cornerRadius = 16
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.setTitleColor(.blue, for: .normal)
        btn.backgroundColor = UIColor(white: 0.95, alpha: 1)
        btn.addTarget(self, action: #selector(btnGetTaped), for: .touchUpInside)
        return btn
    }()
    
    lazy var screenshot1 = self.createScreenshotImageView()
    lazy var screenshot2 = self.createScreenshotImageView()
    lazy var screenshot3 = self.createScreenshotImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
        let labelStackView = VerticalStackView(subviews: [
            appNameLabel, categoryLabel, ratingsLabel])
        
        let appInfoTopStackView = UIStackView(arrangedSubviews: [
            appIconImageView, labelStackView, btnGet])
        appInfoTopStackView.translatesAutoresizingMaskIntoConstraints = false
        appInfoTopStackView.spacing = 12
        appInfoTopStackView.alignment = .center
        
        let appScreenshotStackView = UIStackView(arrangedSubviews: [
            self.screenshot1, self.screenshot2, self.screenshot3])
        appScreenshotStackView.distribution = .fillEqually
        appScreenshotStackView.spacing = 8
        
        let overallStackView = VerticalStackView(subviews: [
            appInfoTopStackView, appScreenshotStackView
            ], spacing: 12)
        
        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        backgroundColor = .white
    }
    
    fileprivate func createScreenshotImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }

    @objc private func btnGetTaped(_ sender: UIButton) {
        self.handleBtnGetSelected?()
    }
}
