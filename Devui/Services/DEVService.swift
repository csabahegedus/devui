//
//  DEVService.swift
//  Devui
//
//  Created by Emilio Schepis on 13/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import Foundation
import Combine
import Resolver
import os.log

class DEVService {
    
    @LazyInjected private var authService: AuthService
    @LazyInjected private var profileCache: Cache<String, Profile>
    @LazyInjected private var articlesCache: Cache<String, [Article]>
    
    private let decoder: JSONDecoder
    private let session: URLSession
    private let baseURL = URL(string: "https://dev.to/api")!
    
    init(decoder: JSONDecoder = JSONDecoder(), session: URLSession = .shared) {
        self.decoder = decoder
        self.session = session
        
        self.decoder.dateDecodingStrategy = .iso8601
    }
    
    func getProfile() -> AnyPublisher<Profile, NetworkError> {
        os_log(.info, log: Loggers.network, "Geting profile")
        
        guard let apiKey = authService.apiKey else {
            os_log(.error, log: Loggers.network, "Failed to get profile: no API key provided")
            return Fail(error: NetworkError.unauthorized)
                .eraseToAnyPublisher()
        }
        
        var components = URLComponents(string: baseURL.absoluteString)!
        components.path.append("/users/me")
        
        let url = components.url!
        
        let cacheKey = url.absoluteString + apiKey
        
        if let profile = profileCache.value(forKey: cacheKey) {
            return Just(profile)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "api-key")
        
        return session.dataTaskPublisher(for: request)
            .tryMap({ result -> Data in
                guard let response = result.response as? HTTPURLResponse else {
                    throw NetworkError.unknown
                }
                
                os_log(.info, log: Loggers.network, "Profile fetch request completed with status code %{PUBLIC}d", response.statusCode)
                
                switch response.statusCode {
                case 200:
                    return result.data
                case 401:
                    throw NetworkError.unauthorized
                default:
                    throw NetworkError.unknown
                }
            })
            .decode(type: Profile.self, decoder: decoder)
            .mapError({ (error: Error) -> NetworkError in
                switch error {
                case is DecodingError:
                    return .decoding
                case is NetworkError:
                    return error as! NetworkError
                default:
                    return .unknown
                }
            })
            .handleEvents(receiveOutput: { profile in
                self.profileCache.insert(profile, forKey: cacheKey)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getArticles(page: Int = 1) -> AnyPublisher<[Article], NetworkError> {
        os_log(.info, log: Loggers.network, "Getting articles, page %{PUBLIC}d", page)
        
        guard let apiKey = authService.apiKey else {
            os_log(.error, log: Loggers.network, "Failed to get articles: no API key provided")
            return Fail(error: NetworkError.unauthorized)
                .eraseToAnyPublisher()
        }
        
        var components = URLComponents(string: baseURL.absoluteString)!
        components.path.append("/articles/me/all")
        components.queryItems = [
            URLQueryItem(name: "page", value: String(describing: page)),
            URLQueryItem(name: "per_page", value: String(describing: Constants.articlesPerPage))
        ]
        
        let url = components.url!
        
        let cacheKey = url.absoluteString + apiKey
        
        if let articles = articlesCache.value(forKey: cacheKey) {
            return Just(articles)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "api-key")
        
        return session.dataTaskPublisher(for: request)
            .tryMap({ result -> Data in
                guard let response = result.response as? HTTPURLResponse else {
                    throw NetworkError.unknown
                }
                
                os_log(.info, log: Loggers.network, "Articles fetch request completed with status code %{PUBLIC}d", response.statusCode)
                
                switch response.statusCode {
                case 200:
                    return result.data
                case 401:
                    throw NetworkError.unauthorized
                default:
                    throw NetworkError.unknown
                }
            })
            .decode(type: [Article].self, decoder: decoder)
            .mapError({ (error: Error) -> NetworkError in
                switch error {
                case is DecodingError:
                    return .decoding
                case is NetworkError:
                    return error as! NetworkError
                default:
                    return .unknown
                }
            })
            .handleEvents(receiveOutput: { articles in
                self.articlesCache.insert(articles, forKey: cacheKey)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
