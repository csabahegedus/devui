//
//  AuthView.swift
//  Devui
//
//  Created by Emilio Schepis on 14/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct AuthView: View {
    
    @ObservedObject private var viewModel = AuthViewModel()
    @State private var showingFAQSheet = false
    
    var logoImage: some View {
        Image("Logo")
            .resizable()
            .scaledToFit()
            .cornerRadius(14)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.primary, lineWidth: 2))
            .frame(maxWidth: 144)
            .accessibility(hidden: true)
    }
    
    var welcomeText: some View {
        Text("app_welcome")
            .bold()
            .multilineTextAlignment(.center)
    }
    
    var apiKeyInput: some View {
        SecureField("generic_api_key", text: $viewModel.apiKey)
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(14)
            .padding(.horizontal)
    }
    
    var faqButton: some View {
        Button(action: { self.showingFAQSheet = true }) {
            Text("faq_prompt")
        }
        .accessibility(hint: Text("accessibility_faq_prompt_hint"))
    }
    
    var signInButton: some View {
        Button(action: viewModel.signIn) {
            Text("generic_next")
                .foregroundColor(.white)
        }
        .padding()
        .frame(minWidth: 128)
        .background(Color.blue)
        .opacity(viewModel.buttonEnabled ? 1 : 0.5)
        .cornerRadius(14)
        .disabled(!viewModel.buttonEnabled)
        .animation(.easeIn(duration: 0.3))
        .padding(.top, 32)
        .accessibility(hint: Text("accessibility_sign_in_button_hint"))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            logoImage
                .offset(x: 0, y: 64)
            
            VStack {
                Spacer()
                welcomeText
                apiKeyInput
                faqButton
                signInButton
                Spacer()
            }
            .offset(x: 0, y: 32)
        }
        .sheet(isPresented: $showingFAQSheet, content: FAQView.init)
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
