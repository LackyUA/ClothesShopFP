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
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Life cyrcle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.pinch(sender:)))
        imageView.addGestureRecognizer(pinchGesture)
    }
    
    // MARK: - Configure cell appearence
    func configureCell(imageUrl: String) {
        imageView.image = UIImage(named: "image-placeholder")
        if let imageUrl = URL(string: imageUrl) {
            loadImage(url: imageUrl)
        }

    }
    private func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            do {
                if let image = UIImage(data: try Data(contentsOf: url)) {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                        self?.activityIndicator.stopAnimating()
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(named: "image-not-available")
                    self?.activityIndicator.stopAnimating()
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
