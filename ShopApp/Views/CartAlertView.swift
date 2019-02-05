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
    var dataForOptionButton: [String: [String: Int]] = [:]
    var delegate: AlertViewDelegate?
    private var options = [Int]()
    private var itemReference: DatabaseReference?
    private var currentUserReference: DatabaseReference?
    
    // MARK: - Outlets
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private var optionButtonsCollection: [UIButton]!
    @IBOutlet private weak var alertView: UIView!
    
    // MARK: - Actions
    @IBAction func optionButtonTapped(_ sender: UIButton) {
        if let dataKey = dataForOptionButton.keys.first {
            switch dataKey {
            case Constants.dataKeys.colors:
                delegate?.optionButtonTapped(option: [Constants.dataKeys.color: sender.backgroundColor?.getHexColor() ?? Constants.defaultValues.hexColor])
                
            case Constants.dataKeys.sizes:
                delegate?.optionButtonTapped(option: [Constants.dataKeys.size: sender.currentTitle ?? Constants.defaultValues.sizeString])
                
            default:
                break
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtonsData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureInterface()
    }
    
    // MARK: - Configure interface
    private func configureInterface() {
        cancelButton.layer.addBorder(side: .top, color: .darkGray, thickness: 0.4)
        
        configureOptionButtons()
        animateView()
    }
    
    private func configureOptionButtons() {
        for button in optionButtonsCollection {
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 3.0
            
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 0.3
        }
    }
    
    private func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + Constants.cartAlertViewInsets.animationHeight
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - Constants.cartAlertViewInsets.animationHeight
        })
    }
    
    // MARK: - Configure button`s data
    private func configureButtonsData() {
        if let dataKey = dataForOptionButton.keys.first {
            switch dataKey {
                
            // MARK: - Configure colors
            case Constants.dataKeys.colors:
                self.headerLabel.text = "Choose your color."
                
                DispatchQueue.global().async {
                    self.dataForOptionButton.values.forEach {
                        
                        for
                            (index, option) in $0.sorted(by: { $0.key < $1.key }).enumerated()
                            where $0.count <= self.optionButtonsCollection.count
                        {
                            DispatchQueue.main.async {
                                
                                for button in self.optionButtonsCollection where button.tag == index {
                                    var color: UInt32 = 0
                                    Scanner(string: option.key).scanHexInt32(&color)
                                    
                                    button.backgroundColor = UIColor(rgb: Int(color))
                                    button.isHidden = false
                                    
                                    if option.value <= 0 {
                                        button.isUserInteractionEnabled = false
                                        button.backgroundColor = button.backgroundColor?.withAlphaComponent(0.2)
                                    }
                                }
                                
                            }
                        }
                    }
                }
            
            // MARK: - Configure sizes
            case Constants.dataKeys.sizes:
                self.headerLabel.text = "Choose your size."
                
                DispatchQueue.global().async {
                    self.dataForOptionButton.values.forEach {
                        
                        for
                            (index, option) in $0.sorted(by: { $0.key < $1.key }).enumerated()
                            where $0.count <= self.optionButtonsCollection.count
                        {
                            DispatchQueue.main.async {
                                
                                for button in self.optionButtonsCollection where button.tag == index {
                                    button.backgroundColor = .none
                                    button.tintColor = .black
                                    button.setTitle("\(option.key)", for: .normal)
                                    button.isHidden = false
                                    
                                    if option.value <= 0 {
                                        button.isUserInteractionEnabled = false
                                        button.tintColor = .lightGray
                                    }
                                }
                                
                            }
                        }
                    }
                }
                
            default:
                break
            }
        }
    }
}

// MARK: - Alert view delegation protocol
protocol AlertViewDelegate: class {
    func optionButtonTapped(option: [String: String])
}
