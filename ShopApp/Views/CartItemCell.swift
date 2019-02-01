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
    @IBOutlet private var itemLabels: [UILabel]!
    @IBOutlet private weak var itemImage: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var itemSizeButton: UIButton!
    @IBOutlet weak var itemColorButton: UIButton!
    @IBOutlet weak var cellView: UIView!
    
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
        configureLabels(item: item)
        configureItemSizeButton(item: item)
        configureItemColorButton(item: item)
        configureCellView()
        
        itemImage.image = UIImage(named: "image-placeholder")
        if let url = URL(string: item.image) {
            loadImage(url: url)
        }
    }
    
    private func configureLabels(item: CartItem) {
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
    }
    
    private func configureItemSizeButton(item: CartItem) {
        itemSizeButton.layer.cornerRadius = 5.0
        itemSizeButton.layer.masksToBounds = true
        itemSizeButton.layer.borderColor = UIColor.black.cgColor
        itemSizeButton.layer.borderWidth = 0.5
        itemSizeButton.setTitle("\(item.size)", for: .normal)
    }
    
    private func configureItemColorButton(item: CartItem) {
        var color: UInt32 = 0
        Scanner(string: item.color).scanHexInt32(&color)
        
        itemColorButton.backgroundColor = UIColor(rgb: Int(color))
        itemColorButton.layer.borderColor = UIColor.black.cgColor
        itemColorButton.layer.borderWidth = 0.5
    }
    
    private func configureCellView() {
        cellView.layer.borderWidth = 0.3
        cellView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func loadImage(url: URL) {
        
        DispatchQueue.global().async { [weak self] in
            do {
                if let image = UIImage(data: try Data(contentsOf: url)) {
                    DispatchQueue.main.async {
                        self?.itemImage.image = image
                        self?.activityIndicator.stopAnimating()
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self?.itemImage.image = UIImage(named: "image-not-available")
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
}
