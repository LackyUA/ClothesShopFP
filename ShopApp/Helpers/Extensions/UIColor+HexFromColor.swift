//
//  UIColor+HexFromColor.swift
//  ShopApp
//
//  Created by Dmytro Dobrovolskyy on 2/4/19.
//  Copyright © 2019 YellowLeaf. All rights reserved.
//

import UIKit

extension UIColor {
    
    func getHexColor() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"0x%06x", rgb)
    }
}
