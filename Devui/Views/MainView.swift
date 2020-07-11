//
//  MainView.swift
//  Devui
//
//  Created by Emilio Schepis on 14/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            ArticlesView()
                .tabItem {
                    if #available(iOS 14, *) {
                        Image(systemName: "doc.append.fill")
                    } else {
                        Image(systemName: "doc.text.fill")
                    }
                    Text("articles_tab")
                }
            FollowersView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("followers_tab")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("profile_tab")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
