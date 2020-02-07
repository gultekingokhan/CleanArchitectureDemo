//
//  SearchBuilder.swift
//  CleanArchitectureDemo
//
//  Created by Gökhan Gültekin on 2020-02-07.
//  Copyright © 2020 Gökhan Gültekin. All rights reserved.
//

import UIKit
import Service

final class SearchBuilder {
    
    static func make() -> SearchViewController {
        let storyboard = UIStoryboard(storyboard: .search)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        viewController.service = SearchService()
        return viewController
    }
}

