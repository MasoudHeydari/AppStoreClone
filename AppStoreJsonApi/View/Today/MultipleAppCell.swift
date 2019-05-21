//
//  MultipleAppCell.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 5/14/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class MultipleAppCell: UICollectionViewCell {
    
    var appFeedResult: FeedResultModel? {
        didSet {
            if let appFeedResult = appFeedResult {
                self.nameLabel.text = appFeedResult.name
                self.companyLabel.text = appFeedResult.artistName
                self.imageView.sd_setImage(with: URL(string: appFeedResult.artworkUrl100 ))
            }
        }
    }
    
    var btnGetSelectHandler: (() -> ())?
    
    // MARK:- Properties
    let imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor(white: 0.95, alpha: 1)
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        image.layer.borderWidth = 1
        return image
    }()
    
    let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 15))
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 12))
    
    let btnGET = UIButton(title: "GET")
    
    let divider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        view.constrainHeight(constant: 0.3)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        addViews()
        addViewsConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        btnGET.addTarget(self, action: #selector(self.btnGETTapped(sender:)), for: .touchUpInside)
        imageView.backgroundColor = UIColor(white: 0.9, alpha: 0.6)
        
        btnGET.backgroundColor = UIColor(white: 0.95, alpha: 1)
        btnGET.titleLabel!.font = .boldSystemFont(ofSize: 16)
        btnGET.constrainWidth(constant: 80)
        btnGET.constrainHeight(constant: 32)
        
        nameLabel.numberOfLines = 2
        companyLabel.textColor = .lightGray
        
        let labelStackView = VerticalStackView(subviews: [
            nameLabel, companyLabel, UIView()
            ])
        
        labelStackView.spacing = 4
        labelStackView.alignment = .top
        labelStackView.backgroundColor = .red
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView, labelStackView, btnGET
            ])
        
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.backgroundColor = .red
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(divider)
        addSubview(stackView)
        
        divider.leftAnchor.constraint(equalTo: (stackView.subviews.first?.rightAnchor)!).isActive = true
        divider.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        divider.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.divider.topAnchor, constant: -1).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        
    }
    
    private func addViews() {
        contentView.backgroundColor = .white
    }
    
    private func addViewsConstraints() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btnGET.layer.cornerRadius = 16

        imageView.constrainHeight(constant: imageView.superview?.frame.height ?? 50)
        imageView.constrainWidth(constant:  imageView.superview?.frame.height ?? 50)
    }
    
    @objc private func btnGETTapped(sender: UIButton) {
        self.btnGetSelectHandler?()
    }
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        setNeedsLayout()
//        layoutIfNeeded()
//        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//
//        print("size \(size)")
//        var newFrame = layoutAttributes.frame
//        // note: don't change the width
//        newFrame.size.height = ceil(size.height)
//        layoutAttributes.frame = newFrame
//        return layoutAttributes
//    }

}
