//
//  FIrebaseHelper.swift
//  ShopApp
//
//  Created by Dmytro Dobrovolskyy on 1/14/19.
//  Copyright © 2019 YellowLeaf. All rights reserved.
//

import Foundation
import Firebase

// MARK: - Firebase model protocol
protocol FirebaseModel {
    init?(snapshot: DataSnapshot)
    func toDictionary() -> [String: Any]
    func removeFromFirebase()
    mutating func createInFirebase()
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
    }
    
    if strings.count > 0 {
        return strings.joined(separator: Constants.firebasePaths.separator)
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
