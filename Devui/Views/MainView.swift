//
//  MainView.swift
//  Devui
//
//  Created by Emilio Schepis on 14/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject private var viewModel = ProfileViewModel()
    @State private var showingProfileActionSheet = false
    
    var profileImage: some View {
        Group {
            viewModel.profileImage
                .map({ NetworkImage(url: $0) })?
                .scaledToFit()
                .aspectRatio(1, contentMode: .fit)
        }
        .frame(width: 32, height: 32, alignment: .center)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.primary, lineWidth: 2))
    }
    
    var profileButton: some View {
        // An actual button here would lose all the padding.
        profileImage
            .onTapGesture { self.showingProfileActionSheet = true }
            .accessibility(label: Text("accessibility_profile_label"))
            .accessibility(hint: Text("accessibility_profile_hint"))
            .accessibility(addTraits: .isButton)
            .accessibility(removeTraits: .isImage)
    }
    
    var body: some View {
        NavigationView {
            ArticlesView()
                .navigationBarTitle("articles_title")
                .navigationBarItems(trailing: profileButton)
                .alert(item: $viewModel.errorMessage) {
                    Alert(title: Text("error_network"), message: Text($0))
                }
                .actionSheet(isPresented: $showingProfileActionSheet) {
                    ActionSheet(title: Text("generic_actions"), buttons: [
                        .destructive(Text("authentication_sign_out"), action: {
                            self.viewModel.signOut()
                        }),
                        .cancel()
                    ])
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
