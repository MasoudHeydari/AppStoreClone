//
//  AppGroupModel.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 4/30/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import Foundation

struct AppGroupModel: Decodable {
    let feed: FeedModel
}

struct FeedModel: Decodable {
    let title: String
    let results: [FeedResultModel]
}

struct FeedResultModel: Decodable {
    let id, name, artistName, artworkUrl100: String
}

struct SocialApp: Decodable {
    let id, name, imageUrl, tagline: String
}
