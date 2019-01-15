//
//  Constants.swift
//  ShopApp
//
//  Created by Dmytro Dobrovolskyy on 1/3/19.
//  Copyright © 2019 YellowLeaf. All rights reserved.
//

import UIKit

class Constants {
    
    // MARK: - Header buttons titles
    struct buttonTitles {
        static let categories = "Categories"
        static let filters = "Filters"
    }
    
    // MARK: - Reusable identifiers
    struct reusableIdentifiers {
        static let headerView = "HeaderView"
        static let shopItemCell = "ShopItemCell"
        static let detailsImageCell = "DetailImageCell"
        static let cartItemCell = "CartItemCell"
    }
    
    // MARK: - Size constants
    struct shopViewInsets {
        static let itemsPerRow: CGFloat = 2
        static let itemHeight: CGFloat = 300
        static let sectionInsets = UIEdgeInsets(top: 30.0, left: 15.0, bottom: 30.0, right: 15.0)
    }
    struct detailViewInsets {
        static let itemsPerRow: CGFloat = 1
        static let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    // MARK: - User defaults
    struct userDefaultsIdentifiers {
        static let fireBaseID = "fireBaseID"
    }
    static let userDefaults = UserDefaults.standard
    
}
