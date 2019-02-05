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
        
        self.uid = snapshotValue[Constants.firebaseItemsKeys.uid].stringValue
        self.name = snapshotValue[Constants.firebaseItemsKeys.name].stringValue
        self.price = snapshotValue[Constants.firebaseItemsKeys.price].doubleValue
        self.count = snapshotValue[Constants.firebaseItemsKeys.count].intValue
        self.images = snapshotValue[Constants.firebaseItemsKeys.images].arrayObject as? [String] ?? [""]
        self.colors = snapshotValue[Constants.firebaseItemsKeys.colors].dictionaryObject as? [String: Int] ?? [:]
        self.sizes = snapshotValue[Constants.firebaseItemsKeys.sizes].dictionaryObject as? [String: Int] ?? [:]
        
        self.categories = stringsArrayWithTrueKeys(snapshotValue: snapshotValue[Constants.firebasePaths.categories].dictionaryObject) ?? [""]
        
        self.firebaseReference = snapshot.ref
    }
    
    func toDictionary() -> [String : Any] {
        return [
            Constants.firebaseItemsKeys.uid: self.uid,
            Constants.firebaseItemsKeys.name: self.name,
            Constants.firebaseItemsKeys.price: self.price,
            Constants.firebaseItemsKeys.count: self.count,
            Constants.firebaseItemsKeys.categories: self.categories,
            Constants.firebaseItemsKeys.images: self.images,
            Constants.firebaseItemsKeys.colors: self.colors,
            Constants.firebaseItemsKeys.sizes: self.sizes
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
