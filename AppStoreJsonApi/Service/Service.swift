//
//  Service.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 4/19/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    public func fetchApps(searchTerm: String, completion: @escaping (SearchResultModel?, Error?) -> Void) {
        let finalSearchTerm = searchTerm.replacingOccurrences(of: " ", with: "%20")
        let urlString = "https://itunes.apple.com/search?term=\(finalSearchTerm)&entity=software"
        self.featchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    public func featchGames(completion: @escaping ([AppGroupModel], [Error]) -> Void) {
        var appGroups = [AppGroupModel]()
        var errors = [Error]()
        
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "name_label_for_dispath_queue")
        let dispatchSemaphore = DispatchSemaphore(value: 0)
        
        let topGames = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json"
        let topGrossing = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json"
        let topIPad = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-paid/all/50/explicit.json"
        let topFree = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/explicit.json"
        
        dispatchQueue.async {
            [topGames, topFree, topGrossing, topIPad, topGrossing].forEach { (urlString) in
                dispatchGroup.enter()
                self.featchAppGroup(urlString: urlString, completion: { (appGroup, error) in
                    if let err = error {
                        errors.append(err)
                        print("there are some error when parsing \(urlString) url - Error is: \(err)")
                    }
                    
                    guard let appGroup = appGroup else { return }
                    appGroups.append(appGroup)
                    
                    dispatchSemaphore.signal()
                    dispatchGroup.leave()
                    
                })
                
                dispatchSemaphore.wait()
            }
        }
        
        dispatchGroup.notify(queue: dispatchQueue) {
            print("app group count: \(appGroups.count)")
            completion(appGroups, errors)
        }
    }
    
    public func featchAppGroup(urlString: String, completion: @escaping (AppGroupModel?, Error?) -> Void) {
        self.featchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    public func featchSocialApp(completion: @escaping ([SocialApp]?, Error?) -> Void) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        self.featchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    public func featchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = TimeInterval(15)
        config.timeoutIntervalForResource = TimeInterval(15)
        let urlSession = URLSession(configuration: config)
        
        guard let url = URL(string: urlString) else { return }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            
            do {
                
                guard let data = data else { return }
                let object = try JSONDecoder().decode(T.self, from: data)
                
                completion(object, nil)
                
            } catch let error {
                completion(nil, error)
                print("featching JSON -> error is ")
            }
        }.resume()
    }
}
