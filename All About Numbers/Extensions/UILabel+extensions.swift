//
//  UILabel+extensions.swift
//  All About Numbers
//
//  Created by Carl Wainwright on 06/07/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func titleLabelSetUp() {
        self.textAlignment = .center
        self.numberOfLines = 0
        self.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        self.font = self.font.bold()
    }

    func setSizeFont (sizeFont: CGFloat) {
        self.font =  UIFont(name: self.font.fontName, size: sizeFont)!
        self.sizeToFit()
    }
}
