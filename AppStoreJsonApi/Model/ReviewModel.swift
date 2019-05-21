//
//  ReviewModel.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 5/8/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import Foundation

struct Reviews: Decodable {
    let feed: ReviewFeed
}

struct ReviewFeed: Decodable {
    let entry: [Entry]
}

struct Entry: Decodable {
    let title: Label
    let content: Label
    let author: Author
    let rating: Label
    
    private enum CodingKeys: String, CodingKey {
        case title, author, content
        case rating = "im:rating"
    }
}

struct Author: Decodable {
    let uri: Label
    let name: Label
    let label: String
}

struct Label: Decodable {
    let label: String
}


/*
 
 {
 author: {
 uri: {
 label: "https://itunes.apple.com/us/reviews/id17911153"
 },
 name: {
 label: "CharlesV"
 },
 label: ""
 },
 im:version: {
 label: "1.0.6"
 },
 im:rating: {
 label: "3"
 },
 id: {
 label: "4071430592"
 },
 title: {
 label: "Good adaptation, frustrating crashes"
 },
 content: {
 label: "Playing on a 2018 iPad Pro, the game crashes every 15 minutes or so of gameplay. For something that’s well done, immersive, and makes me want to keep going, repaying from the last checkpoint so many times is supremely frustrating.",
 attributes: {
 type: "text"
 }
 },
 link: {
 attributes: {
 rel: "related",
 href: "https://itunes.apple.com/us/review?id=1152350815&type=Purple%20Software"
 }
 },
 im:voteSum: {
 label: "0"
 },
 im:contentType: {
 attributes: {
 term: "Application",
 label: "Application"
 }
 },
 im:voteCount: {
 label: "0"
 }
 }
 
 */
