//
//  SearchPresentation.swift
//  CleanArchitectureDemo
//
//  Created by Gökhan Gültekin on 2020-02-07.
//  Copyright © 2020 Gökhan Gültekin. All rights reserved.
//

import Foundation
import Service

final class SearchPresentation: NSObject {
    
    typealias Track = SearchResponse.Result
    
    var trackName: String?
    var coverURL: URL?
    var artistName: String?
    
    init(_ response: Track) {
        trackName = response.trackName
        artistName = response.artistName
        coverURL = response.artworkUrl60 == nil ? nil : URL(string: response.artworkUrl60!)
    }
    
    convenience init(response: Track) {
        self.init(response)
    }
}
