//
//  AppDelegate+Injection.swift
//  Devui
//
//  Created by Emilio Schepis on 13/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerCaches()
        registerServices()
    }
}

extension Resolver {
    public static func registerCaches() {
        register(name: "images") { Cache<String, Data>() }.scope(application)
        register { Cache<String, Profile>() }.scope(application)
        register { Cache<String, [Article]>() }.scope(application)
        register { Cache<String, [Follower]>() }.scope(application)
    }
}

extension Resolver {
    public static func registerServices() {
        register { AuthService() }.scope(application)
        register { DEVService() }.scope(application)
        register { ImagesService() }.scope(application)
    }
}
