//
//  SearchContracts.swift
//  CleanArchitectureDemo
//
//  Created by Gökhan Gültekin on 2020-02-07.
//  Copyright © 2020 Gökhan Gültekin. All rights reserved.
//

import UIKit

@objc protocol SearchViewProtocol: class {
    weak var delegate: SearchViewDelegate? { get set }
    func setLoading(_ isLoading: Bool)
}

@objc protocol SearchViewDelegate: class { }

