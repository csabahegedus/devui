//
//  ArticlesListItemView.swift
//  Devui
//
//  Created by Emilio Schepis on 14/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ArticlesListItemView: View {
    
    @ObservedObject private var viewModel: ArticlesListItemViewModel
    @State private var showingShareSheet = false
    
    init(_ article: Article) {
        self.viewModel = ArticlesListItemViewModel(article)
    }
    
    var coverImage: some View {
        Group {
            viewModel.coverImage
                .map({ NetworkImage(url: $0) })
                .scaledToFill()
                .frame(height: 64)
                .clipped()
        }
    }
    
    var titleText: some View {
        Text(viewModel.title)
            .lineLimit(3)
            .font(.headline)
            .foregroundColor(Color(UIColor.label))
    }
    
    var descriptionText: some View {
        Text(viewModel.description)
            .italic()
            .lineLimit(1)
            .font(.subheadline)
            .foregroundColor(Color(UIColor.secondaryLabel))
    }
    
    var tagsList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.tags, id: \.self, content: Text.init)
            }
            .font(.footnote)
            .foregroundColor(Color(UIColor.secondaryLabel))
            .accessibilityElement(children: .ignore)
            .accessibility(label: Text(viewModel.accessibilityTags))
        }
    }
    
    var publishedText: some View {
        Text(viewModel.published)
            .lineLimit(1)
            .font(.subheadline)
            .foregroundColor(Color(UIColor.tertiaryLabel))
    }
    
    var shareButton: some View {
        Button(action: { self.showingShareSheet = true }) {
            Image(systemName: "square.and.arrow.up")
        }
        .buttonStyle(BorderlessButtonStyle())
        .accessibility(label: Text("generic_share"))
    }
    
    var actionsView: some View {
        HStack(alignment: .center){
            interactionsView
            Spacer()
            shareButton
        }
    }
    
    var interactionsView: some View {
        ArticlesListItemInteractionsView(viewModel.wrapped)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            coverImage
                .accessibility(hidden: true)
                
            VStack(alignment: .leading, spacing: 8) {
                titleText
                descriptionText
                tagsList
                publishedText
                
                Divider()
                    .padding(.bottom)
                
                actionsView
            }
            .padding()
        }
        .cornerRadius(14)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .foregroundColor(Color(UIColor.secondarySystemBackground))
                .shadow(radius: 4)
        )
        .sheet(isPresented: $showingShareSheet) {
            ActivityView(activityItems: [self.viewModel.url])
        }
    }
}

struct ArticlesListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesListItemView(.example)
    }
}
