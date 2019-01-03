//
//  ViewController.swift
//  ShopApp
//
//  Created by Dmytro Dobrovolskyy on 11/7/18.
//  Copyright © 2018 YellowLeaf. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class ViewController: UIViewController {

    // MARK: - Constants
    private let reusableCellIdentifier = "ProductCell"
    
    // MARK: - Properties
    private var ref : DatabaseReference!
    private var items = [Item]()
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegations()
        ref =  Database.database().reference()
        ref.child("assortment/items").observe(DataEventType.value) { snapshot in
            let json = JSON(snapshot.value as? [String : Any] ?? [:])
            json.forEach({ value in
                self.items.append(Item.fromJSON(json.dictionaryObject ?? [:], withID: value.0))
            })
            self.items.forEach({ item in
                self.tableView.reloadData()
                print("ID: \(item.id)\nNAME: \(item.name)\nCATEGORIES: \(item.categories)\nIMAGES: \(item.images)")
            })
        }
    }
    private func delegations() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}

// MARK: - Table view delegation and data source
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = items[indexPath.item].name
        
        return cell
    }
    
}

