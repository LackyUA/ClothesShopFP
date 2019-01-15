//
//  CartItemCell.swift
//  ShopApp
//
//  Created by Dmytro Dobrovolskyy on 1/10/19.
//  Copyright © 2019 YellowLeaf. All rights reserved.
//

import UIKit

class CartItemCell: UITableViewCell {
    
    // MARK: - Properties
    weak var delegate: CartCellDelegate?

    // MARK: - Outlets
    @IBOutlet private weak var itemImage: UIImageView!
    @IBOutlet private var itemLabels: [UILabel]!
    @IBOutlet private weak var itemSizeButton: UIButton!
    @IBOutlet private weak var itemColorButton: UIButton!
    
    // MARK: - Actions
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            delegate?.removeCell(self)
            
        case 1:
            delegate?.changeSize(self)
            
        case 2:
            delegate?.changeColor(self)
            
        default:
            break
        }
    }
    
    // MARK: - Configuring cell appearence
    func configureCell(item: CartItem) {
        if let url = URL(string: item.image) {
            loadImage(url: url)
        }
        
        for itemLabel in itemLabels {
            switch itemLabel.tag {
            case 0:
                itemLabel.text = item.name
                
            case 1:
                itemLabel.text = "Price: \(item.price)$"
                
            default:
                break
            }
        }
        
        itemSizeButton.layer.cornerRadius = 5.0
        itemSizeButton.layer.masksToBounds = true
        itemSizeButton.layer.borderColor = UIColor.black.cgColor
        itemSizeButton.layer.borderWidth = 0.5
        itemSizeButton.setTitle("\(item.size)", for: .normal)
        
        itemColorButton.layer.borderColor = UIColor.black.cgColor
        itemColorButton.layer.borderWidth = 0.5
        itemColorButton.backgroundColor = .red
    }
    private func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.itemImage.image = image
                    }
                }
            }
        }
    }
    
}
