//
//  APIRouter.swift
//  Service
//
//  Created by Gökhan Gültekin on 2020-02-07.
//  Copyright © 2020 Gökhan Gültekin. All rights reserved.
//

import Foundation
import Alamofire

public struct APIRouter {
    
    public struct RequestConfiguration {
        
        let method: HTTPMethod
        let path: APIRouter.Path
        let urlComponents: [String]?
        let body: [String: Any]?
        let headers: [String: String]?
        let files: [Data]?
        
        init(method: HTTPMethod,
             path: APIRouter.Path,
             urlComponents: [String]? = [],
             body: [String: Any]? = nil,
             headers: [String: String]? = nil,
             files: [Data]? = nil) {
            self.method = method
            self.path = path
            self.urlComponents = urlComponents
            self.body = body
            self.headers = headers
            self.files = files
        }
    }
    
    enum Path: String {
        case search = "/search"
    }
    
    static func makeURL(path: APIRouter.Path) -> URL? {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        
        // MARK: If you have environments like dev, stage or production, here is a good place to set base URLs or other url components.
        urlComponents.host = "itunes.apple.com"
        
        // MARK: API version can be also added like this:
        // urlComponents.path.append("/api/v1")
        
        urlComponents.path.append(path.rawValue)
        
        return urlComponents.url
    }
}

public class XError: Error {
    
    public enum `Type` {
        case unauthorizedCredentials
        case brokenAPI
        case system
    }
    
    public var code: Int
    public var message: String
    public var type: Type
    
    init(code: Int, message: String, type: Type) {
        self.code = code
        self.message = message
        self.type = type
    }
}

public enum Result<Value> {
    case success(Value)
    case failure(XError)
}
