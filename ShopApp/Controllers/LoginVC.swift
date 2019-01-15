//
//  LoginVC.swift
//  ShopApp
//
//  Created by Dmytro Dobrovolskyy on 1/14/19.
//  Copyright © 2019 YellowLeaf. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    // MARK: - Properties
    private weak var currentUser: User?
    
    // MARK: - Outlets
    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    
    // MARK: - Actions
    @IBAction private func buttonTapped(_ sender: UIButton) {
        if
            let email = self.emailField.text,
            let password = self.passwordField.text
        {
            switch sender.tag {
            case 0:
                // MARK: - Authentification
                Auth.auth().signIn(withEmail: email, password: password)
                
            case 1:
                // MARK: - Register and auto authentification
                registerWithCredentinal(withEmail: email, password: password)
                
            default:
                break
            }
        }
    }
    @IBAction func signOut(segue: UIStoryboardSegue) {
        do {
            try Auth.auth().signOut()
        } catch {
            self.present(UIAlertController.withError(error: error as NSError),
                         animated: true,
                         completion: nil)
        }
    }
    
    // MARK: - Life cyrcle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil && user != self.currentUser {
                self.currentUser = user
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    self.performSegue(withIdentifier: "LoggedIn", sender: self)
                }
            }
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
       Auth.auth().removeStateDidChangeListener(self)
    }
    
    // MARK: - Registration method
    private func registerWithCredentinal(withEmail email: String, password: String) {
        Auth.auth().createUser(
            withEmail: email,
            password: password) { user, error in
                if error != nil {
                    self.present(UIAlertController.withError(error: error! as NSError),
                                 animated: true,
                                 completion: nil)
                } else {
                    if let uid = Auth.auth().currentUser?.uid {
                        
                        var user = LoggedUser(uid: uid, email: email)
                        user.createInFirebase()
                    }
                }
        }
    }

}
