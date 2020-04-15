//
//  FAQView.swift
//  Devui
//
//  Created by Emilio Schepis on 15/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct FAQView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    init() {
        UITableView.appearance().separatorStyle = .singleLine
    }
    
    func openURL(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    var closeButton: some View {
        Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            Text("generic_close")
        }
        .accessibility(hint: Text("accessibility_faq_close_hint"))
    }
    
    var body: some View {
        NavigationView {
            List(allFAQs) { faq in
                VStack(alignment: .leading, spacing: 8) {
                    Text(faq.question)
                        .font(.headline)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    Text(faq.answer)
                        .font(.subheadline)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                    
                    if faq.relatedURL != nil {
                        Button(action: { self.openURL(faq.relatedURL!) }) {
                            Text("faq_more_info")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
            .navigationBarTitle(Text("faq_title"), displayMode: .inline)
            .navigationBarItems(trailing: closeButton)
        }
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView()
    }
}
