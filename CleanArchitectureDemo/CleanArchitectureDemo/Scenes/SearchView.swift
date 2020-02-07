//
//  SearchView.swift
//  CleanArchitectureDemo
//
//  Created by Gökhan Gültekin on 2020-02-07.
//  Copyright © 2020 Gökhan Gültekin. All rights reserved.
//

import UIKit

final class SearchView: UIView {
    
    weak var delegate: SearchViewDelegate?

    @IBOutlet var testLabel: UILabel!
}

extension SearchView: SearchViewDelegate {
    
}
