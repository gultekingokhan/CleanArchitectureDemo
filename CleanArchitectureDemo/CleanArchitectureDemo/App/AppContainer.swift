//
//  AppContainer.swift
//  CleanArchitectureDemo
//
//  Created by Gökhan Gültekin on 2020-02-07.
//  Copyright © 2020 Gökhan Gültekin. All rights reserved.
//

import Foundation

public let app = AppContainer()

public final class AppContainer {
    
    let router = AppRouter()
    
    var settings: Settings = Settings()
    
    struct Settings {
        
        private enum keys: String {
            case rememberMe
        }
        
        var rememberMe: Bool { // Example setting
            
            get {
                return UserDefaults.standard.bool(forKey: keys.rememberMe.rawValue)
            }
            set {
                UserDefaults.standard.set(newValue, forKey: keys.rememberMe.rawValue)
            }
        }
        
        init() { }
    }
}
