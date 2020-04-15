//
//  ArticlesListItemInteractionsView.swift
//  Devui
//
//  Created by Emilio Schepis on 14/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ArticlesListItemInteractionsView: View {
    
    @ObservedObject private var viewModel: ArticlesListItemInteractionsViewModel
    
    init(_ article: Article) {
        self.viewModel = ArticlesListItemInteractionsViewModel(article)
    }
    
    var body: some View {
        HStack(spacing: 12) {
            HStack(spacing: 4) {
                Image(systemName: "eye.fill")
                Text(viewModel.pageViewsCount)
                    .bold()
            }
            .frame(minWidth: 16)
            .foregroundColor(.green)
            HStack(spacing: 4) {
                Image(systemName: "heart.fill")
                Text(viewModel.positiveReactionsCount)
                    .bold()
            }
            .frame(minWidth: 16)
            .foregroundColor(.red)
            HStack(spacing: 4) {
                Image(systemName: "bubble.right.fill")
                Text(viewModel.commentsCount)
                    .bold()
            }
            .frame(minWidth: 16)
            .foregroundColor(.blue)
        }
        .accessibilityElement(children: .ignore)
        .accessibility(label: Text(viewModel.accessibilityLabel))
    }
}

struct ArticlesListItemInteractionsView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesListItemInteractionsView(.example)
    }
}
