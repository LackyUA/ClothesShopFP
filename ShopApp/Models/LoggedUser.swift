//
//  LoggedUser.swift
//  ShopApp
//
//  Created by Dmytro Dobrovolskyy on 1/14/19.
//  Copyright © 2019 YellowLeaf. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct LoggedUser: FirebaseModel {
    
    // MARK: - Properties
    var firebaseReference: DatabaseReference?
    
    // MARK: - Canstants
    let uid: String
    let email: String
    
    // MARK: - Inits
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    init?(snapshot: DataSnapshot) {
        if
            let snapshotValue = snapshot.value as? [String: Any],
            let uid = snapshotValue[Constants.firebaseUserKeys.uid] as? String,
            let email = snapshotValue[Constants.firebaseUserKeys.email] as? String
        {
            self.uid = uid
            self.email = email
            
            self.firebaseReference = snapshot.ref
        } else {
            return nil
        }
    }
    
    // MARK: - Convertion to dictionary
    func toDictionary() -> [String: Any] {
        return [
            Constants.firebaseUserKeys.uid: self.uid,
            Constants.firebaseUserKeys.email: self.email
        ]
    }
    
    // MARK: - Remove user from Firebase
    func removeFromFirebase() {
        self.firebaseReference?.removeValue()
    }
    
    // MARK: - Create and save user in Firebase
    mutating func createInFirebase() {
        let reference = Database.database().reference(withPath: Constants.firebasePaths.users)
        self.firebaseReference = reference.child(self.uid)
        self.firebaseReference?.setValue(self.toDictionary())
    }
    
    // MARK: - Methods for getting user`s path
    static func pathFor(uid: String) -> String {
        return [Constants.firebasePaths.users, uid].joined(separator: Constants.firebasePaths.separator)
    }
    func path() -> String {
        return LoggedUser.pathFor(uid: self.uid)
    }
}
