//
//  HeaderReusableView.swift
//  ShopApp
//
//  Created by Dmytro Dobrovolskyy on 1/3/19.
//  Copyright © 2019 YellowLeaf. All rights reserved.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
    
    // MARK: - Outlets
    @IBOutlet private var headerButtons: [UIButton]!
    
    // MARK: - Actions
    // TODO: - Add acctions for buttons and configure filters and categories.
    
    // MARK: - Configuration header
    func configureHeader() {
        for button in headerButtons {
            button.layer.cornerRadius = Constants.shopHeaderViewInsets.cornerRadius
            button.layer.masksToBounds = true
            
            switch button.tag {
            case 0:
                button.setTitle(Constants.buttonTitles.categories, for: .normal)
            case 1:
                button.setTitle(Constants.buttonTitles.filters, for: .normal)
            default:
                break
            }
        }
    }
}
