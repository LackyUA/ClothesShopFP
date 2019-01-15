//
//  FirebaseModel.swift
//  ShopApp
//
//  Created by Dmytro Dobrovolskyy on 1/14/19.
//  Copyright © 2019 YellowLeaf. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol FirebaseModel {
    init?(snapshot: DataSnapshot)
    func toDictionary() -> [String: Any]
    func removeFromFirebase()
    mutating func createInFirebase()
}
