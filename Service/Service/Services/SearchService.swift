//
//  SearchService.swift
//  Service
//
//  Created by Gökhan Gültekin on 2020-02-07.
//  Copyright © 2020 Gökhan Gültekin. All rights reserved.
//

import Foundation

public protocol SearchServiceProtocol {
    func search(_ text: String, completion: @escaping(Result<SearchResponse>) -> Void)
}

open class SearchService: SearchServiceProtocol {
    
    public init() { }
    
    public func search(_ text: String, completion: @escaping(Result<SearchResponse>) -> Void) {
        print("🔎 Searching \(text)...")
                
        let configuration = APIRouter.RequestConfiguration(method: .get, path: .search, body: ["term":text], headers: nil)
        
        APIClient.request(configuration: configuration) { (result) in
            
            switch result {
            case .success(let data):
                
                guard let response: SearchResponse = try? JSONDecoder().decode(SearchResponse.self, from: data) else {
                    print("Search response could not be decoded.")
                    return
                }
                
                completion(.success(response))
                
                break
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

public struct SearchResponse: Codable {
    
    let resultCount: Int
    public let results: [Result]
    
    public struct Result: Codable {
        
        let wrapperType: WrapperType
        let kind: String?
        let trackId: Int?
        public let artistName: String
        let collectionName: String
        public let trackName: String?
        let trackViewURL: String?
        let previewURL: String
        public let artworkUrl30, artworkUrl60, artworkUrl100: String?

        enum CodingKeys: String, CodingKey {
            case wrapperType, kind, trackId, artworkUrl30, artworkUrl60, artworkUrl100, artistName, collectionName, trackName
            case trackViewURL = "trackViewUrl"
            case previewURL = "previewUrl"
        }
    }
    
    enum WrapperType: String, Codable {
        case audiobook = "audiobook"
        case track = "track"
    }
}
