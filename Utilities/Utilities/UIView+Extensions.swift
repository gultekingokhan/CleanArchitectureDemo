//
//  UIView+Extensions.swift
//  Utilities
//
//  Created by Gökhan Gültekin on 2020-02-07.
//  Copyright © 2020 Gökhan Gültekin. All rights reserved.
//

import UIKit

public extension UIView {
    
    func dropShadow(with color: UIColor) {
        
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 3, height: 3);
        layer.shadowOpacity = 1
        layer.shadowRadius = 5
        layer.shadowColor = color.cgColor
    }
}
