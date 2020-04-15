//
//  Article.swift
//  Devui
//
//  Created by Emilio Schepis on 13/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import Foundation

struct Article: Identifiable, Decodable {
    
    let id: Int
    let title: String
    let description: String
    let coverImage: String?
    let tags: [String]
    let url: String
    let commentsCount: Int
    let positiveReactionsCount: Int
    let pageViewsCount: Int
    let published: Bool
    let publishedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case coverImage = "cover_image"
        case tags = "tag_list"
        case url
        case commentsCount = "comments_count"
        case positiveReactionsCount = "positive_reactions_count"
        case pageViewsCount = "page_views_count"
        case published
        case publishedAt = "published_at"
    }
    
    static let example = Article(id: 0,
                                 title: "How I created a DEV dashboard with SwiftUI and Combine",
                                 description: "The story of how two new technologies some other long text here to fill the lines.",
                                 coverImage: "https://via.placeholder.com/512",
                                 tags: ["swiftui", "combine", "ios", "meta"],
                                 url: "https://dev.to/emilioschepis/some-fake-slug-url-for-the-article",
                                 commentsCount: 8,
                                 positiveReactionsCount: 42,
                                 pageViewsCount: 1337,
                                 published: true,
                                 publishedAt: Date().addingTimeInterval(-4 * 24 * 60 * 60))
}
