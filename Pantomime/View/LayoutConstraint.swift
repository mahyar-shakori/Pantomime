//
//  File.swift
//  Pantomime
//
//  Created by Mahyar on 11/19/23.
//

import UIKit

@IBDesignable
class LayoutConstraint: NSLayoutConstraint {
    
    @IBInspectable
    var 📱smallSc: CGFloat = 0 {
        didSet {
            if UIScreen.main.bounds.maxY <= 667 {
                constant = 📱smallSc
            }
        }
    }

    @IBInspectable
    var 📱mediumSc: CGFloat = 0 {
        didSet {
            if (736...895).contains(UIScreen.main.bounds.maxY) {
                constant = 📱mediumSc
            }
        }
    }
    
    @IBInspectable
    var 📱largeSc: CGFloat = 0 {
        didSet {
            if UIScreen.main.bounds.maxY >= 896 {
                constant = 📱largeSc
            }
        }
    }
}

