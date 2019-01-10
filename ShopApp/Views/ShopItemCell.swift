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
    
    // MARK: - Configure cell appearence
    func configureCell(imageUrl: String, description: NSAttributedString) {
        loadImage(url: URL(string: imageUrl)!)
        itemDescriptionLabel.attributedText = description
    }
    private func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.itemImageView.image = image
                    }
                }
            }
        }
    }
    
}
