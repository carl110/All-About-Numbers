//
//  UIViewController+extensions.swift
//  All About Numbers
//
//  Created by Carl Wainwright on 06/07/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    //custom aler message
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    //insert image as background
    func backgroundSetup(image: UIImage) {
        let backgroundImage = UIImageView(frame: view.bounds)
        backgroundImage.image = image
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
}
