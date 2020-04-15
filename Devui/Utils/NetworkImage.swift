//
//  NetworkImage.swift
//  Devui
//
//  Created by Emilio Schepis on 14/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI
import Combine
import Resolver

private final class NetworkImageViewModel: ObservableObject {
    
    @LazyInjected private var imagesService: ImagesService
    
    private let url: URL
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var image: Image?
    
    init(_ url: URL) {
        self.url = url
        
        imagesService.getImageData(at: url)
            .replaceError(with: Data())
            .compactMap({ UIImage(data: $0) })
            .map({ Image(uiImage: $0) })
            .assign(to: \.image, on: self)
            .store(in: &cancellables)
    }
}

struct NetworkImage: View {
    
    @ObservedObject private var viewModel: NetworkImageViewModel
    
    init(url: URL) {
        viewModel = NetworkImageViewModel(url)
    }
    
    init(urlString: String) {
        self.init(url: URL(string: urlString)!)
    }
    
    var body: some View {
        return Group {
            if viewModel.image != nil {
                viewModel.image?.resizable()
            } else {
                Rectangle().foregroundColor(.gray)
            }
        }
    }
}

struct NetworkImage_Previews: PreviewProvider {
    static var previews: some View {
        NetworkImage(urlString: Article.example.coverImage!)
    }
}
