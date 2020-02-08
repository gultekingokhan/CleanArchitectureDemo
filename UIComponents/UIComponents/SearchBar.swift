//
//  SearchBar.swift
//  UIComponents
//
//  Created by Gökhan Gültekin on 2020-02-08.
//  Copyright © 2020 Gökhan Gültekin. All rights reserved.
//

import UIKit

open class SearchBar: UITextField {
    
    private var padding: UIEdgeInsets {
        get {
            return UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
        }
        set { }
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
