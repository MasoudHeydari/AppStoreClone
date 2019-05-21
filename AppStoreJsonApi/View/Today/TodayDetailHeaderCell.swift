//
//  TodayDetailHeaderCell.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 5/9/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class TodayDetailHeaderCell: UITableViewCell {
    
    // MARK:- Properties
    
    let todayCell = TodayCell()
    
    let btnClose: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isUserInteractionEnabled = true
        return btn
    }()
    
    var handleBtnCloseTapped: (() -> ())?
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        layer.cornerRadius = 16
        
        addSubview(todayCell)
        addSubview(btnClose)
        
        todayCell.fillSuperview()
        btnClose.addTarget(self, action: #selector(btnCloseTapped), for: .touchUpInside)
        
        let statusBarheight = UIApplication.shared.statusBarFrame.height
        
        btnClose.topAnchor.constraint(equalTo: topAnchor, constant: 10 + statusBarheight).isActive = true
        btnClose.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        btnClose.widthAnchor.constraint(equalToConstant: 38).isActive = true
        btnClose.heightAnchor.constraint(equalToConstant: 38).isActive = true
    }
    
    @objc private func btnCloseTapped(_ sender: UIButton) {
        print("btn close tapped!")
        self.handleBtnCloseTapped?()
    }
}
