//
//  SearchViewController.swift
//  CleanArchitectureDemo
//
//  Created by Gökhan Gültekin on 2020-02-07.
//  Copyright © 2020 Gökhan Gültekin. All rights reserved.
//

import UIKit
import Service

final class SearchViewController: UIViewController {
    
    @IBOutlet weak var customView: SearchView! {
        didSet {
            customView.delegate = self
        }
    }
    
    var service: SearchService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search("Pearl Jam")
    }
    
    func search(_ text: String) {
        
        customView.setLoading(true)
        
            service.cancelRequest()

        service.search(text) { [weak self] (result) in
            
            guard let self = self else { return }
                        
            self.customView.setLoading(false)
            
            switch result {
            case .success(let value):
                
                let searchResults = value.results.map(SearchPresentation.init)
                self.customView.updateSearchResults(searchResults)
                
                break
            case .failure(let error):
                print("Error occured while fetching the search results: \(error.localizedDescription)")
                break
            }
        }
    }
}

extension SearchViewController: SearchViewDelegate {
    func searchTextUpdated(_ text: String) {
        search(text)
    }
}
