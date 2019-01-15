//
//  FIrebaseHelper.swift
//  ShopApp
//
//  Created by Dmytro Dobrovolskyy on 1/14/19.
//  Copyright © 2019 YellowLeaf. All rights reserved.
//

import Foundation
import Firebase

let FirebasePathSeparator = "/"
let FirebasePhotosPath = "photos"
let FirebaseEmptyValue = "null"

enum FirebasePaths: String {
    case assortment = "assortment"
    case users = "users"
    case categories = "categories"
    case items = "items"
}

enum FirebaseItemsKeys: String {
    case uid = "uid"
    case categories = "categories"
    case colors = "colors"
    case sizes = "sizes"
    case count = "count"
    case images = "images"
    case name = "name"
    case price = "price"
    case color = "color"
    case size = "size"
    case image = "image"
}

enum FirebaseUserKeys: String {
    case uid = "uid"
    case email = "email"
    case items = "items"
    case size = "size"
    case color = "color"
    case image = "image"
    case name = "name"
    case price = "price"
}

func createFirebaseReference(components: [Any]?) -> DatabaseReference? {
    if let path = firebasePath(components: components) {
        return Database.database().reference(withPath: path)
    }
    return nil
}

func createFirebaseStorageReference(components: [Any]?) -> StorageReference? {
    if let path = firebasePath(components: components) {
        let storage = Storage.storage()
        let reference = storage.reference(withPath: path)
        return reference
    }
    return nil
}

fileprivate func firebasePath(components: [Any]?) -> String? {
    guard let components = components else {
        return nil
    }
    
    var strings = [String]()
    for thing in components {
        if let string = thing as? String {
            strings.append(string)
        }
        
        if let path = thing as? FirebasePaths {
            strings.append(path.rawValue)
        }
    }
    
    if strings.count > 0 {
        return strings.joined(separator: FirebasePathSeparator)
    }
    
    return nil
}

/* Converts a dictionary of keys and bools to an array of strings with "true" keys */
func stringsArrayWithTrueKeys(snapshotValue: Any?) -> [String]? {
    var result: [String]? = nil
    
    if let dict = snapshotValue as? [String: Bool] {
        
        var keys = [String]()
        dict.forEach {
            if $0.value == true {
                keys.append($0.key)
            }
        }
        
        if keys.count > 0 {
            result = keys
        } else {
            result = nil
        }
    }
    return result
}
