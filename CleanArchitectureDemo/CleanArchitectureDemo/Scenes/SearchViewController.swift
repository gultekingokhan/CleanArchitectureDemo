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
        
        service.search("Behemoth") { (response) in }
    }
}

extension SearchViewController: SearchViewDelegate { }
