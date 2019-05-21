//
//  TodayDetailController.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 5/9/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class TodayDetailFullScreenController: UITableViewController {
    
    private let cellId = "cell_id"
    private let headerCellId = "header_cell_id"
    
    var todayItem: TodayItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
        }
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never 
        
        tableView.register(TodayDetailHeaderCell.self, forCellReuseIdentifier: headerCellId)
        tableView.register(TodayDetailCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell selected!")
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: headerCellId, for: indexPath) as? TodayDetailHeaderCell else { return UITableViewCell() }
            cell.todayCell.todayItem = self.todayItem
            cell.todayCell.layer.cornerRadius = 0
            // for disabling show, you must set 'clipToBounds' property to TRUE
            cell.clipsToBounds = true
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TodayDetailCell else { return UITableViewCell() }
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 400
        default:
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}
