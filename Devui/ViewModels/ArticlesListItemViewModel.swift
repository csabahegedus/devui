//
//  ArticlesListItemViewModel.swift
//  Devui
//
//  Created by Emilio Schepis on 13/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import Foundation
import Combine
import Resolver

class ArticlesListItemViewModel: ObservableObject {
    
    private let article: Article
    
    private lazy var relativeDateFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        
        return formatter
    }()
    
    var wrapped: Article { article }
    
    var title: String { article.title }
    var description: String { article.description }
    var tags: [String] { article.tags.map({ "#\($0)" }) }
    var published: String { formatPublishedString() }
    var pageViewsCount: String { String(describing: article.pageViewsCount) }
    var positiveReactionsCount: String { String(describing: article.positiveReactionsCount) }
    var commentsCount: String { String(describing: article.commentsCount) }
    var coverImage: URL? { URL(string: article.coverImage ?? "") }
    var url: URL { URL(string: article.url)! }
    
    var accessibilityTags: String {
        String(format: NSLocalizedString("accessibility_tags_label_param", comment: ""), article.tags.joined(separator: ","))
    }
    
    init(_ article: Article) {
        self.article = article
    }
    
    func formatPublishedString() -> String {
        if article.published, let date = article.publishedAt {
            let relativeString = relativeDateFormatter.localizedString(for: date, relativeTo: Date())
            return String(format: NSLocalizedString("article_published_param", comment: ""), relativeString)
        } else {
            return NSLocalizedString("article_not_published")
        }
    }
}
