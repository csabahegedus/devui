//
//  ArticlesListItemInteractionsViewModel.swift
//  Devui
//
//  Created by Emilio Schepis on 14/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import Foundation
import Combine
import Resolver

class ArticlesListItemInteractionsViewModel: ObservableObject {
    
    private let article: Article
    
    var pageViewsCount: String { String(describing: article.pageViewsCount) }
    var positiveReactionsCount: String { String(describing: article.positiveReactionsCount) }
    var commentsCount: String { String(describing: article.commentsCount) }
    
    var accessibilityLabel: String {
        String(format: NSLocalizedString("accessibility_interactions_label_param", comment: ""), article.pageViewsCount, article.positiveReactionsCount, article.commentsCount)
    }
    
    init(_ article: Article) {
        self.article = article
    }
}
