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
        static let loginSegueIdentifier = "LoggedIn"
        static let cartAlertViewIdentifier = "CartAlertIdentifier"
        static let detailsViewIdentifier = "Details"
    }
    
    // MARK: - Size constants
    struct shopViewInsets {
        static let itemsPerRow: CGFloat = 2.0
        static let itemHeight: CGFloat = 300.0
        static let headerHeight: CGFloat = 60.0
        static let sectionInsets = UIEdgeInsets(top: 30.0, left: 15.0, bottom: 30.0, right: 15.0)
    }
    struct detailViewInsets {
        static let itemsPerRow: CGFloat = 1.0
        static let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    struct cartAlertViewInsets {
        static let animationHeight: CGFloat = 500.0
    }
    struct shopHeaderViewInsets {
        static let cornerRadius: CGFloat = 8.0
    }
    
    // MARK: - User defaults
    struct userDefaultsIdentifiers {
        static let fireBaseID = "fireBaseID"
    }
    static let userDefaults = UserDefaults.standard
    
    // MARK: - Data transfering keys
    struct dataKeys {
        static let size = "size"
        static let sizes = "sizes"
        
        static let color = "color"
        static let colors = "colors"
    }
    
    // MARK: - Default values
    struct defaultValues {
        static let hexColor = "0x000000"
        static let sizeString = "37"
        static let sizeInt = 37
    }
    
    // MARK: - Image names
    struct imageNames {
        static let imageAvailablePlaceholder = "image-placeholder"
        static let imageNotAvailablePlaceholder = "image-not-available"
    }
    
    // MARK: - Firebase path values
    struct firebasePaths {
        static let separator = "/"
        static let photos = "photos"
        static let emptyValue = "null"
        static let assortment = "assortment"
        static let users = "users"
        static let categories = "categories"
        static let items = "items"
    }
    
    // MARK: - Firebase keys for items reference
    struct firebaseItemsKeys {
        static let uid = "uid"
        static let categories = "categories"
        static let colors = "colors"
        static let sizes = "sizes"
        static let count = "count"
        static let images = "images"
        static let name = "name"
        static let price = "price"
        static let color = "color"
        static let size = "size"
        static let image = "image"
    }
    
    // MARK: - Firebase keys for user reference
    struct firebaseUserKeys {
        static let uid = "uid"
        static let email = "email"
        static let cart = "cart"
        static let size = "size"
        static let color = "color"
        static let image = "image"
        static let name = "name"
        static let price = "price"
    }
}
