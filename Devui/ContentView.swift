//
//  ContentView.swift
//  Devui
//
//  Created by Emilio Schepis on 13/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var authService: AuthService
    
    var body: some View {
        Group {
            if authService.apiKey != nil {
                MainView()
            } else {
                AuthView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
