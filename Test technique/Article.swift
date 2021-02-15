//
//  Article.swift
//  Test technique
//
//  Created by Emilio Del Castillo on 15/02/2021.
//

import Foundation

struct Article: Codable {
    var title: String!
    var description: String!
    var pubDate: Double!
    var link: String!
    var urlImage: String!
    var copyright: String!
    var category: String!
}

struct NewsFeed: Codable {
    var status: Int!
    var data: [Article]!
}
