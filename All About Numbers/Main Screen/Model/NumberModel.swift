//
//  NumberModel.swift
//  All About Numbers
//
//  Created by Carl Wainwright on 06/07/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation

class NumberModel {
    var text: String
    var found: Bool
    var number: String
    var type: String
    var date: Data?
    var year: String?
    
    init(text: String, found: Bool, number: String, type: String) {
        self.text = text
        self.found = found
        self.number = number
        self.type = type
    }

}
