//
//  CurrentUser.swift
//  ShopApp
//
//  Created by Dmytro Dobrovolskyy on 1/15/19.
//  Copyright © 2019 YellowLeaf. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import UIKit

struct CurrentUser {
    
    let uid: String
    
    init?() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return nil
        }
        self.uid = uid
    }
    
    func itemsPath() -> String {
        return [FirebasePaths.users.rawValue,
                self.uid,
                FirebaseUserKeys.cart.rawValue].joined(separator: FirebasePathSeparator)
    }
    
    func addCartItem(uid: String, value: [String: Any]) {
        if let path = CurrentUser()?.itemPath(uid: uid) {
            let reference = Database.database().reference(withPath: path)
            reference.setValue(value)
        }
    }
    
    func updateCartItem(uid: String, value: [String: Any]) {
        if let path = CurrentUser()?.itemPath(uid: uid) {
            let reference = Database.database().reference(withPath: path)
            reference.updateChildValues(value)
        }
    }
    
    private func itemPath(uid: String) -> String {
        return [FirebasePaths.users.rawValue,
                self.uid,
                FirebaseUserKeys.cart.rawValue,
                uid].joined(separator: FirebasePathSeparator)
    }
    
    func path() -> String {
        return LoggedUser.pathFor(uid: self.uid)
    }
}
