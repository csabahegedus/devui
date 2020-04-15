//
//  ImagesService.swift
//  Devui
//
//  Created by Emilio Schepis on 14/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import Foundation
import Combine
import Resolver

class ImagesService {
    
    @LazyInjected(name: "images") private var cache: Cache<String, Data>
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getImageData(at url: URL) -> AnyPublisher<Data, NetworkError> {
        let cacheKey = url.absoluteString
        
        if let data = cache.value(forKey: cacheKey) {
            return Just(data)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .map({ $0.data })
            .mapError({ (error: Error) -> NetworkError in
                return .unknown
            })
            .handleEvents(receiveOutput: { data in
                self.cache.insert(data, forKey: cacheKey)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
