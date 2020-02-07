//
//  ResourceLoader.swift
//  Service
//
//  Created by Gökhan Gültekin on 2020-02-07.
//  Copyright © 2020 Gökhan Gültekin. All rights reserved.
//

import Foundation

public class ResourceLoader: NSObject {

    public enum File: String {
        case search = "search-response"
    }
    
    public static func loadFile(file: File) throws -> Data? {
        
        let bundle = Bundle(for: ResourceLoader.self)
        
        guard let path = bundle.path(forResource: file.rawValue, ofType: "json") else { return nil }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped) else { return nil }
        return data
    }
}

