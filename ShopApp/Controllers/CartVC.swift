//
//  CartVC.swift
//  ShopApp
//
//  Created by Dmytro Dobrovolskyy on 1/10/19.
//  Copyright © 2019 YellowLeaf. All rights reserved.
//

import UIKit

class CartVC: UIViewController {

    // MARK: - Properties
    var items = [
        Item(id: "213213", name: "Nike boi 228", price: 24.99, categories: [""], images: ["https://assets.adidas.com/images/w_600,f_auto,q_auto/2f488fe90ddf43fdbe77a8c100ca2bb3_9366/POD-S3_1_Shoes_Black_AQ1059_01_standard.jpg", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6Lhi6cQGkSJy26V_vAJ7GkkFcNYZuStFdcj92i1qpj1zpvVqS"]),
        Item(id: "213213", name: "Addiki XL 780 water proof resistance edition", price: 35.99, categories: [""], images: ["https://assets.adidas.com/images/w_600,f_auto,q_auto/2f488fe90ddf43fdbe77a8c100ca2bb3_9366/POD-S3_1_Shoes_Black_AQ1059_01_standard.jpg", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6Lhi6cQGkSJy26V_vAJ7GkkFcNYZuStFdcj92i1qpj1zpvVqS"]),
        Item(id: "213213", name: "sadsadsa dsa dasd sad sadasdasd sadasdas  asd asd asdasdas", price: 24.99, categories: [""], images: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6Lhi6cQGkSJy26V_vAJ7GkkFcNYZuStFdcj92i1qpj1zpvVqS"]),
        Item(id: "213213", name: "sadsadsa dsa dasd sad sadasdasd sadasdas dasdлдрмрпс", price: 24.99, categories: [""], images: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6Lhi6cQGkSJy26V_vAJ7GkkFcNYZuStFdcj92i1qpj1zpvVqS"])
    ]
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var totalPriceLabel: UILabel!
    
    // MARK: - Life cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegation()
        totalPriceLabel.text = "Total price: \(totalPrice())$"
    }
    private func delegation() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Calculate total price
    func totalPrice() -> Double {
        var totalPrice = 0.0
        for item in items {
            totalPrice += item.price
        }
        
        return totalPrice
    }

}

// MARK: - Configure table view delegate
extension CartVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        print("My index is... \(indexPath.row)!")
    }
    
}

// MARK: - Configure table view data source
extension CartVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reusableIdentifiers.cartItemCell, for: indexPath) as? CartItemCell {
            
            cell.configureCell(item: items[indexPath.row])
            cell.delegate = self
            
            return cell
        }
        
        return UITableViewCell()
    }
    
}

// MARK: - Configure deleting item from cart
extension CartVC: CartCellDelegate {
    func removeCell(_ sender: CartItemCell) {
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        
        items.remove(at: tappedIndexPath.row)
        tableView.deleteRows(at: [tappedIndexPath], with: .automatic)
        totalPriceLabel.text = "Total price: \(totalPrice())$"
    }
}

// MARK: - Cart cell delegate protocol
protocol CartCellDelegate: class {
    func removeCell(_ sender: CartItemCell)
}
