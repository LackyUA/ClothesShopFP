//
//  UIAlertController+Message.swift
//  ShopApp
//
//  Created by Dmytro Dobrovolskyy on 2/4/19.
//  Copyright © 2019 YellowLeaf. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func withError(error: NSError) -> UIAlertController {
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok",
                                         style: .default)
        alert.addAction(cancelAction)
        return alert
    }
    
    static func withMessage(message: String) -> UIAlertController {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok",
                                         style: .default)
        alert.addAction(cancelAction)
        return alert
    }
}
