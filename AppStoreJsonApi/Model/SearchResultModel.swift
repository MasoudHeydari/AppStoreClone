//
//  SearchResultModel.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 4/19/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

struct SearchResultModel: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackId: Int
    let trackName: String
    let primaryGenreName: String
    let artworkUrl100: String // app icon
    let artworkUrl512: String // app icon
    let screenshotUrls: [String]
    var averageUserRating: CGFloat?
    var formattedPrice: String?
    let description: String
    let releaseNotes: String?
    let sellerName: String
}
