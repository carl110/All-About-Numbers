//
//  UITextField+extensions.swift
//  All About Numbers
//
//  Created by Carl Wainwright on 08/07/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {

    
    func setAutoTextSize() {
        DispatchQueue.main.async { [weak self] in
            self?.backgroundColor = UIColor.Yellows.mustardYellow
            self?.textColor = UIColor.Reds.standardRed
            //roundedcorners
            self?.roundCorners(for: [.bottomLeft, .bottomRight], cornerRadius: 8)
 
            //Auto adjust size of text as you type
            self?.font = .boldSystemFont(ofSize: (self?.frame.height)!)
            self?.textAlignment = .center
        }
        
    }
    
    //Check if UITextField is empty
    var isEmpty: Bool {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
    
}
