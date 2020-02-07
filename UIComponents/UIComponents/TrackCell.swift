//
//  TrackCell.swift
//  UIComponents
//
//  Created by Gökhan Gültekin on 2020-02-07.
//  Copyright © 2020 Gökhan Gültekin. All rights reserved.
//

import UIKit
import Utilities

open class TrackCell: UITableViewCell {
    
    @IBOutlet public weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 18
            containerView.dropShadow(with: UIColor(hex: 0xEBEBEB))
        }
    }
    
    @IBOutlet public weak var trackNameLabel: UILabel! {
        didSet {
            trackNameLabel.textColor = .darkGray
        }
    }
    
    @IBOutlet public weak var artistNameLabel: UILabel! {
        didSet {
            artistNameLabel.textColor = .gray
        }
    }
    
    @IBOutlet public weak var albumCoverImageView: UIImageView! {
        didSet {
            albumCoverImageView.contentMode = .scaleAspectFit
            albumCoverImageView.layer.cornerRadius = albumCoverImageView.frame.width/2
        }
    }
}
