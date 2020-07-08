//
//  UIButton+extensions.swift
//  All About Numbers
//
//  Created by Carl Wainwright on 06/07/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func titleButtonSetup() {
        DispatchQueue.main.async { [weak self] in
            self?.backgroundColor = UIColor.Reds.standardRed
            self?.setTitleColor(UIColor.Yellows.mustardYellow, for: .normal)
            self?.titleLabel?.font = UIFont.boldSystemFont(ofSize: (self?.frame.height)! / 1.5)
            self?.titleLabel?.adjustsFontSizeToFitWidth = true
            self?.centerTextHorizontally(spacing: 8)
            self?.contentVerticalAlignment = .center
            self?.roundCorners(for: .allCorners, cornerRadius: 8)
        }
        
    }
    
    
    func centerTextHorizontally(spacing: CGFloat) {
        //adds spacing/padding to thew left and right
        titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        //centers text
        self.titleLabel?.textAlignment = NSTextAlignment.center
    }
    
    func enableButton() {
        alpha = 1.0
        isEnabled = true
    }
    
    func disableButton() {
        alpha = 0.0
        isEnabled = false
    }
}

