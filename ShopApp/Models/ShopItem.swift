//
//  Item.swift
//  ShopApp
//
//  Created by Dmytro Dobrovolskyy on 11/7/18.
//  Copyright © 2018 YellowLeaf. All rights reserved.
//

import Foundation
import SwiftyJSON
import Firebase

struct ShopItem: FirebaseModel {
    
    var currentUsersPath: String {
        let currentUser = CurrentUser()
        
        return currentUser?.path() ?? ""
    }
    
    let uid: String
    let name: String
    let price: Double
    let count: Int
    let categories: [String]
    let images: [String]
    let colors: [String : Int]
    let sizes: [String : Int]
    var firebaseReference: DatabaseReference?
    
    init( uid: String = "",
          name: String = "",
          price: Double = 0.0,
          count: Int = 0,
          categories: [String] = [""],
          images: [String] = [""],
          colors: [String : Int] = [:],
          sizes: [String : Int] = [:] )
    {
        self.uid = uid
        self.name = name
        self.price = price
        self.count = count
        self.categories = categories
        self.images = images
        self.colors = colors
        self.sizes = sizes
        self.firebaseReference = nil
    }

    init?(snapshot: DataSnapshot) {
        let snapshotValue = JSON(snapshot.value as Any)
        
        self.uid = snapshotValue[FirebaseItemsKeys.uid.rawValue].stringValue
        self.name = snapshotValue[FirebaseItemsKeys.name.rawValue].stringValue
        self.price = snapshotValue[FirebaseItemsKeys.price.rawValue].doubleValue
        self.count = snapshotValue[FirebaseItemsKeys.count.rawValue].intValue
        self.images = snapshotValue[FirebaseItemsKeys.images.rawValue].arrayObject as? [String] ?? [""]
        self.colors = snapshotValue[FirebaseItemsKeys.colors.rawValue].dictionaryObject as? [String: Int] ?? [:]
        self.sizes = snapshotValue[FirebaseItemsKeys.sizes.rawValue].dictionaryObject as? [String: Int] ?? [:]
        
        self.categories = stringsArrayWithTrueKeys(snapshotValue: snapshotValue[FirebaseItemsKeys.categories.rawValue].dictionaryObject) ?? [""]
        
        self.firebaseReference = snapshot.ref
    }
    
    func toDictionary() -> [String : Any] {
        return [
            FirebaseItemsKeys.uid.rawValue: self.uid,
            FirebaseItemsKeys.name.rawValue: self.name,
            FirebaseItemsKeys.price.rawValue: self.price,
            FirebaseItemsKeys.count.rawValue: self.count,
            FirebaseItemsKeys.categories.rawValue: self.categories,
            FirebaseItemsKeys.images.rawValue: self.images,
            FirebaseItemsKeys.colors.rawValue: self.colors,
            FirebaseItemsKeys.sizes.rawValue: self.sizes
        ]
    }
    
    func removeFromFirebase() {
        self.firebaseReference?.removeValue()
    }
    
    mutating func createInFirebase() {
        guard let reference = createFirebaseReference(components: [currentUsersPath]) else {
            fatalError("Can't create cart item path")
        }
        
        self.firebaseReference = reference.child(self.uid)
        self.firebaseReference?.setValue(self.toDictionary())
    }
}
