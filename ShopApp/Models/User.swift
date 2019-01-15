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
    let uid: String
    let email: String
    var firebaseReference: DatabaseReference?
//    let ownedPartiesKeys: [String: Any]?
//    let attendingPartiesKeys: [String: Any]?
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
//        self.ownedPartiesKeys = nil
//        self.attendingPartiesKeys = nil
    }
    
    init?(snapshot: DataSnapshot) {
        if let snapshotValue = snapshot.value as? [String: Any],
            let uid = snapshotValue[FirebaseUserKeys.uid.rawValue] as? String,
            let email = snapshotValue[FirebaseUserKeys.email.rawValue] as? String
        {
            self.uid = uid
            self.email = email
            
//            self.ownedPartiesKeys = snapshotValue[FirebaseUserKeys.ownedParties.rawValue] as? [String: Any]
//            self.attendingPartiesKeys = snapshotValue[FirebaseUserKeys.attendingParties.rawValue] as? [String: Any]
            
            self.firebaseReference = snapshot.ref
        } else {
            return nil
        }
    }
    
    func toDictionary() -> [String: Any] {
        return [
            FirebaseUserKeys.uid.rawValue: self.uid,
            FirebaseUserKeys.email.rawValue: self.email,
        ]
    }
    
    func removeFromFirebase() {
        self.firebaseReference?.removeValue()
    }
    
    mutating func createInFirebase() {
        let reference = Database.database().reference(withPath: FirebasePaths.users.rawValue)
        self.firebaseReference = reference.child(self.uid)
        self.firebaseReference?.setValue(self.toDictionary())
    }
    
    static func pathFor(uid: String) -> String {
        return [FirebasePaths.users.rawValue, uid].joined(separator: FirebasePathSeparator)
    }
    
    func path() -> String {
        return LoggedUser.pathFor(uid: self.uid)
    }
}
