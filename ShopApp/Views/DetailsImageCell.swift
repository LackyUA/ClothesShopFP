//
//  ImageCell.swift
//  ShopApp
//
//  Created by Dmytro Dobrovolskyy on 1/3/19.
//  Copyright © 2019 YellowLeaf. All rights reserved.
//

import UIKit

class DetailsImageCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: - Life cyrcle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.pinch(sender:)))
        imageView.addGestureRecognizer(pinchGesture)
    }
    
    // MARK: - Configure cell appearence
    func configureCell(imageUrl: String) {
        loadImage(url: URL(string: imageUrl)!)
    }
    private func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                    }
                }
            }
        }
    }
    
    // MARK: - Configure image zoom
    @objc func pinch(sender: UIPinchGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            if !(sender.scale < 1.0) {
                self.imageView.transform = CGAffineTransform(
                    scaleX: self.imageView.frame.size.width / self.imageView.frame.size.width * sender.scale,
                    y: self.imageView.frame.size.width / self.imageView.frame.size.width * sender.scale
                )
            }
            
        case .ended:
            self.imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            sender.scale = 1
            
        default:
            break
        }
    }
    
}
