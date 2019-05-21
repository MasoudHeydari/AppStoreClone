//
//  AppsSearchController.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 4/19/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class AppsSearchController: BaseCollectionViewController {
    
    // MARK:- Properties
    fileprivate var appResults = [Result]()
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate var timer: Timer?
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        return indicator
    }()
    
    let searchLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above ..."
        label.textAlignment = .center
        label.textColor = UIColor(white: 0.5, alpha: 0.7)
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        registerCollectionViewCell()
        setupSearchBar()
        setupSearchLabel()
        setupActivityIndicator()
    }
    
    fileprivate func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
    }
    
    private func fetchITunesApps(searchTerm: String) {
        
        Service.shared.fetchApps(searchTerm: searchTerm) { (searchResult, err)  in
            
            // check for potential error ?
            if let err = err {
                print("failed to fetch app from itunes! ", err)
                return
            }
            guard let searchResult = searchResult else { return }
            // all things is done
            self.appResults = searchResult.results
            self.reloadCollectionViewData()
            
            print("searchResult: \(searchResult.results.count)")
            
            self.handleSearchLabelIfIsDone(searchTerm: searchTerm)
        }
    }
    
    fileprivate func handleSearchLabelIfIsDone(searchTerm: String) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            if self.appResults.count == 0 {
                self.searchLabel.isHidden = false
                self.searchLabel.text = searchTerm != Const.empty ? "There is no result for '\(searchTerm)'" : "Please enter search term above ..."
            }
            
        }
    }
}

/***************************************************/
/*************** SEARCH BAR DELEGATE ***************/
/***************************************************/

extension AppsSearchController: UISearchBarDelegate {
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    fileprivate func setupSearchLabel() {
        view.addSubview(searchLabel)
        searchLabel.fillSuperview()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.searchLabel.isHidden = true
            self.activityIndicator.startAnimating()
            self.fetchITunesApps(searchTerm: searchText)
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if self.appResults.count != 0 {
            self.appResults.removeAll()
            self.collectionView.reloadData()
            handleSearchLabelIfIsDone(searchTerm: Const.empty)
        }
    }
}

/***********************************************/
/*************** COLLECTION VIEW ***************/
/***********************************************/

extension AppsSearchController {
    
    fileprivate func setupCollectionView() {
        collectionView.keyboardDismissMode = .onDrag
        collectionView.backgroundColor = .white
    }
    
    fileprivate func registerCollectionViewCell() {
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: Const.ID.Cell.appsSearch)
    }
    
    fileprivate func reloadCollectionViewData() {
        DispatchQueue.main.async {
            // must reload collectionview's data model
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        self.searchLabel.isHidden = appResults.count != 0
        return self.appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appId = String(self.appResults[indexPath.item].trackId)
        let appDetailController = AppDetailController(appId: appId)
        navigationController?.pushViewController(appDetailController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 330)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // unwrap the cell safely. added by: Masoud Heydari 10:35 AM - 19 April 2019
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.ID.Cell.appsSearch, for: indexPath) as? SearchResultCell else { return UICollectionViewCell() }
        
        // it is recomende to use 'item' when use 'UICollectionView', if you use tableView use 'row' insted!  added by: Masoud Heydari - 10:13 PM - 19 April 2019
        cell.appResult = self.appResults[indexPath.item]
        cell.handleBtnGetSelected = {
            print("btn get in search controller tapped!")
        }
        return cell
    }
}

