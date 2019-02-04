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
            case "colors":
                delegate?.optionButtonTapped(option: ["color": sender.backgroundColor?.getHexColor() ?? "0x000000"])
                
            case "sizes":
                delegate?.optionButtonTapped(option: ["size": sender.currentTitle ?? "37"])
                
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
//        getDataFromFirebase()
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
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 3.0
            
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
    
    // MARK: - Configure button`s data
    private func configureButtonsData() {
        if let dataKey = dataForOptionButton.keys.first {
            switch dataKey {
            case "colors":
                DispatchQueue.global().async {
                    self.dataForOptionButton.values.forEach {
                        $0.forEach {
                            if $0.value > 0 {
                                var color: UInt32 = 0
                                Scanner(string: $0.key).scanHexInt32(&color)
                                
                                self.options.append(Int(color))
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.headerLabel.text = "Choose your color."
                        
                        for (index, option) in self.options.enumerated() {
                            for button in self.optionButtonsCollection where button.tag == index {
                                button.backgroundColor = UIColor(rgb: option)
                                button.isHidden = false
                            }
                        }
                    }
                }
                
            case "sizes":
                DispatchQueue.global().async {
                    self.dataForOptionButton.values.forEach {
                        $0.forEach {
                            if $0.value > 0 {
                                self.options.append(Int($0.key) ?? 33)
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.headerLabel.text = "Choose your size."
                        
                        for (index, option) in self.options.enumerated() {
                            for button in self.optionButtonsCollection where button.tag == index {
                                button.backgroundColor = .none
                                button.setTitle("\(option)", for: .normal)
                                button.tintColor = .black
                                button.isHidden = false
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
