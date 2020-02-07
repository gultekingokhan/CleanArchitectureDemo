//
//  TrackCell.swift
//  UIComponents
//
//  Created by Gökhan Gültekin on 2020-02-07.
//  Copyright © 2020 Gökhan Gültekin. All rights reserved.
//

import UIKit

open class TrackCell: UITableViewCell {
    
    @IBOutlet public var nameLabel: UILabel! {
        didSet {
            nameLabel.textColor = .darkGray
        }
    }
}
