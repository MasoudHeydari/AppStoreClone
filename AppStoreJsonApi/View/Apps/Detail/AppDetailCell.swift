//
//  AppDetailCell.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 5/3/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit
import SDWebImage

class AppDetailCell: UICollectionViewCell {
    
    var result: Result? {
        didSet {
            if let result = result {
                //                print("observer called! \(result.trackName)")
                self.namelabel.text = result.trackName
                self.btnGET.setTitle(result.formattedPrice, for: .normal)
                self.releaseNoteLabel.text = result.releaseNotes
                self.sellerlabel.text = result.sellerName
                self.appIconImageView.sd_setImage(with: URL(string: result.artworkUrl512))
                
            }
        }
    }
    
    var btnGetDidSelect: (() -> ())?
    
    private(set) lazy var btnGET: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor(red: 45/255, green: 108/255, blue: 241/255, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.constrainWidth(constant: 80)
        btn.addTarget(self, action: #selector(handleBtnGettapped(_:)), for: .touchUpInside)
        return btn
    }()
    
    private(set) lazy var namelabel: UILabel = {
        let label = UILabel()
        label.text = "App Name"
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    private(set) lazy var sellerlabel: UILabel = {
        let label = UILabel()
        label.text = "Seller Name"
        label.numberOfLines = 1
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private(set) lazy var whatsNewLabel: UILabel = {
        let label = UILabel()
        label.text = "what's New"
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private(set) lazy var releaseNoteLabel: UILabel = {
        let label = UILabel()
        label.text = "Release Note"
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var appIconImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor(white: 0.95, alpha: 1)
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        image.layer.borderWidth = 1
        return image
    }()
    
    private(set) lazy var btnGETStackView: UIStackView = {
        let stackView = UIStackView(subviews: [btnGET, UIView()], customSpacing: 1)
        return stackView
        
    }()
    
    lazy var nameAndBtnStackView: VerticalStackView = {
        let stackView = VerticalStackView(subviews: [namelabel, sellerlabel, UIView(), btnGETStackView], spacing: 6)
        return stackView
        
    }()
    
    lazy var iconAndNameLabelStackView: UIStackView = {
        let stackView = UIStackView(subviews: [appIconImageView, nameAndBtnStackView], customSpacing: 12)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        self.backgroundColor = .white
        
        appIconImageView.constrainHeight(constant: frame.width / 3)
        appIconImageView.constrainWidth(constant: frame.width / 3)
        
        //        btnGET.constrainWidth(constant: 80)
        
        let overallStackView = VerticalStackView(subviews: [iconAndNameLabelStackView, whatsNewLabel, releaseNoteLabel], spacing: 12)
        
        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btnGET.layer.cornerRadius = btnGET.bounds.height / 2
    }
    
    @objc private func handleBtnGettapped(_ sender: UIButton ) {
        self.btnGetDidSelect?()
    }
}
