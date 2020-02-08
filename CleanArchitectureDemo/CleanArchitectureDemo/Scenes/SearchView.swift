//
//  SearchView.swift
//  CleanArchitectureDemo
//
//  Created by Gökhan Gültekin on 2020-02-07.
//  Copyright © 2020 Gökhan Gültekin. All rights reserved.
//

import UIKit
import UIComponents
import SDWebImage
import Utilities

final class SearchView: UIView {
    
    weak var delegate: SearchViewDelegate?
    
    var searchResults: [SearchPresentation]?
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.backgroundColor = .clear
        }
    }
    
    @IBOutlet var searchTextField: SearchBar! {
        didSet {
            searchTextField.placeholder = "Try John Lennon"
            searchTextField.dropShadow(with: UIColor(hex: 0xEBEBEB))
            searchTextField.backgroundColor = .white
            searchTextField.tintColor = .darkGray
            searchTextField.delegate = self
        }
    }
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.color = .gray
            activityIndicator.startAnimating()
        }
    }
}

extension SearchView: SearchViewProtocol {
    
    func setLoading(_ isLoading: Bool) {
        activityIndicator.isHidden = !isLoading
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
            
            cell.trackNameLabel.text = result.trackName ?? "-"
            cell.artistNameLabel.text = result.artistName ?? "-"
            
            if let coverURL = result.coverURL {
                cell.albumCoverImageView.sd_setImage(with: coverURL)
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension SearchView: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            var updatedText = text.replacingCharacters(in: textRange, with: string)
            updatedText = updatedText.replacingOccurrences(of: " ", with: "+")
            delegate?.searchTextUpdated(updatedText)
        }
        return true
    }
}
