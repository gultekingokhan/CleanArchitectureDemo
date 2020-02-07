//
//  SearchView.swift
//  CleanArchitectureDemo
//
//  Created by Gökhan Gültekin on 2020-02-07.
//  Copyright © 2020 Gökhan Gültekin. All rights reserved.
//

import UIKit
import UIComponents

final class SearchView: UIView {
    
    weak var delegate: SearchViewDelegate?

    var searchResults: [SearchPresentation]?
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
}

extension SearchView: SearchViewProtocol {
    
    func setLoading(_ isLoading: Bool) {
        // TODO: Do not forget to implement
    }
    
    func updateSearchResults(_ presentation: [SearchPresentation]) {
        searchResults = presentation
        tableView.reloadData()
    }
}

extension SearchView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as? TrackCell {
           
            guard let results = searchResults else { return UITableViewCell() }
            
            let result = results[indexPath.row]
           
            cell.nameLabel.text = result.trackName ?? "-"
            
            return cell
        }
        return UITableViewCell()
    }
}
