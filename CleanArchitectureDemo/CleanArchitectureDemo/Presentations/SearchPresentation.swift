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
 
    init(_ response: Track) {
        trackName = response.trackName
    }
    
    convenience init(response: Track) {
        self.init(response)
    }
}
