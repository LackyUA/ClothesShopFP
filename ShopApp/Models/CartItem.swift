//
//  CartItem.swift
//  ShopApp
//
//  Created by Dmytro Dobrovolskyy on 1/11/19.
//  Copyright © 2019 YellowLeaf. All rights reserved.
//

import Foundation
import SwiftyJSON
import FirebaseDatabase

struct CartItem: FirebaseModel {
    
    var currentUsersPath: String {
        let currentUser = CurrentUser()
        
        return currentUser?.path() ?? ""
    }
    
    let uid: String
    let name: String
    let price: Double
    let image: String
    let size: Int
    let color: String
    var firebaseReference: DatabaseReference?
    
    init( uid: String = "",
          name: String = "",
          price: Double = 0.0,
          image: String = "",
          size: Int = 0,
          color: String = "" )
    {
        self.uid = uid
        self.name = name
        self.price = price
        self.image = image
        self.size = size
        self.color = color
        self.firebaseReference = nil
    }
    
    init?(snapshot: DataSnapshot) {
        let snapshotValue = JSON(snapshot.value as Any)
        
        self.uid = snapshotValue[FirebaseItemsKeys.uid.rawValue].stringValue
        self.name = snapshotValue[FirebaseItemsKeys.name.rawValue].stringValue
        self.image = snapshotValue[FirebaseItemsKeys.image.rawValue].stringValue
        self.color = snapshotValue[FirebaseItemsKeys.color.rawValue].stringValue
        self.size = snapshotValue[FirebaseItemsKeys.size.rawValue].intValue
        self.price = snapshotValue[FirebaseItemsKeys.price.rawValue].doubleValue
        self.firebaseReference = snapshot.ref
    }
    
    func toDictionary() -> [String : Any] {
        return [
            FirebaseItemsKeys.uid.rawValue: self.uid,
            FirebaseItemsKeys.name.rawValue: self.name,
            FirebaseItemsKeys.image.rawValue: self.image,
            FirebaseItemsKeys.color.rawValue: self.color,
            FirebaseItemsKeys.size.rawValue: self.size,
            FirebaseItemsKeys.price.rawValue: self.price
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
