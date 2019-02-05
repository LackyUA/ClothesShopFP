//
//  ItemCell.swift
//  ShopApp
//
//  Created by Dmytro Dobrovolskyy on 11/7/18.
//  Copyright © 2018 YellowLeaf. All rights reserved.
//

import UIKit

class ShopItemCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var itemImageView: UIImageView!
    @IBOutlet private weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Configure cell appearence
    func configureCell(imageUrl: String, description: NSAttributedString) {
        itemImageView.image = UIImage(named: Constants.imageNames.imageAvailablePlaceholder)
        if let imageUrl = URL(string: imageUrl) {
            loadImage(url: imageUrl)
        }
        itemDescriptionLabel.attributedText = description
    }
    private func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            do {
                if let image = UIImage(data: try Data(contentsOf: url)) {
                    DispatchQueue.main.async {
                        self?.itemImageView.image = image
                        self?.activityIndicator.stopAnimating()
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self?.itemImageView.image = UIImage(named: Constants.imageNames.imageNotAvailablePlaceholder)
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
}
