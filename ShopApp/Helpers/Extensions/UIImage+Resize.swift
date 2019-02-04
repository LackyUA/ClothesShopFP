//
//  UIImage+Resize.swift
//  ShopApp
//
//  Created by Dmytro Dobrovolskyy on 2/4/19.
//  Copyright © 2019 YellowLeaf. All rights reserved.
//

import UIKit

extension UIImage {
    
    func resized(width: CGFloat) -> UIImage? {
        let image = self
        let height = CGFloat(ceil(width/image.size.width * image.size.height))
        let canvasSize = CGSize(width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, image.scale)
        defer { UIGraphicsEndImageContext() }
        image.draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
