//
//  NetworkError.swift
//  Devui
//
//  Created by Emilio Schepis on 13/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case badURL
    case decoding
    case unauthorized
    case unknown
    
    public var errorDescription: String? {
        switch self {
        case .badURL:
            return NSLocalizedString("error_network_url")
        case .decoding:
            return NSLocalizedString("error_network_decoding")
        case .unauthorized:
            return NSLocalizedString("error_network_unauthorized")
        case .unknown:
            return NSLocalizedString("error_unknown")
        }
    }
}
