//
//  AlertView.swift
//  ShopApp
//
//  Created by Dmytro Dobrovolskyy on 1/31/19.
//  Copyright © 2019 YellowLeaf. All rights reserved.
//

import UIKit
import Firebase

class CartAlertView: UIViewController {

    // MARK: - Properties
    var itemIdentifier: String = "id"
    var delegate: AlertViewDelegate?
    private var colors = [Int]()
    private var itemReference: DatabaseReference?
    private var currentUserReference: DatabaseReference?
    
    // MARK: - Outlets
    @IBOutlet private weak var headrLabel: UILabel!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private var optionButtonsCollection: [UIButton]!
    @IBOutlet private weak var alertView: UIView!
    
    // MARK: - Actions
    @IBAction func optionButtonTapped(_ sender: UIButton) {
        delegate?.optionButtonTapped(selectedState: (sender.backgroundColor ?? .black, nil))
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        delegate?.optionButtonTapped(selectedState: (nil, sender.title(for: .normal)))
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromFirebase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureInterface()
        animateView()
    }
    
    // MARK: - Configure interface
    private func configureInterface() {
        cancelButton.layer.addBorder(side: .top, color: .darkGray, thickness: 0.4)
        
        configureOptionButtons()
    }
    
    private func configureOptionButtons() {
        for button in optionButtonsCollection {
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 0.3
        }
    }
    
    private func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 500
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 500
        })
    }
    
    // MARK: - Get data from Firebase
    private func getDataFromFirebase() {
        
        if let reference = createFirebaseReference(components: [FirebasePaths.assortment.rawValue, FirebasePaths.items.rawValue, itemIdentifier]) {
            self.itemReference = reference
            
            self.itemReference?.observe(.value, with: { snapshot in
                
                var itemFromSnapshot = ShopItem()
                if let item = ShopItem(snapshot: snapshot) {
                    itemFromSnapshot = item
                }
                
                DispatchQueue.global().async {
                    itemFromSnapshot.colors.forEach {
                        if $0.value != 0 {
                            var color: UInt32 = 0
                            Scanner(string: $0.key).scanHexInt32(&color)
                            
                            self.colors.append(Int(color))
                        }
                    }
                    DispatchQueue.main.async {
                        for (index, color) in self.colors.enumerated() {
                            for button in self.optionButtonsCollection where button.tag == index {
                                button.backgroundColor = UIColor(rgb: color)
                                button.isHidden = false
                            }
                        }
                    }
                }
            })
        }
    }
}

// MARK: - Alert view delegation protocol
protocol AlertViewDelegate: class {
    func optionButtonTapped(selectedState: (UIColor?, String?))
}
