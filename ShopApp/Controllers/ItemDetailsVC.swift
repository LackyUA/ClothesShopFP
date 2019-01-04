//
//  ItemDetailsVC.swift
//  ShopApp
//
//  Created by Dmytro Dobrovolskyy on 1/3/19.
//  Copyright © 2019 YellowLeaf. All rights reserved.
//

import UIKit

class ItemDetailsVC: UIViewController {

    // MARK: - Constants
    private let itemsPerRow: CGFloat = 1
    private let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    
    // MARK: - Properties
    var item = Item()
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Actions
    @IBAction func backToListTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        // Favorite button
        case 0:
            sender.tintColor = .green
            print("Favorite")
            
        // Card button
        case 1:
            print("Card")
            
        default:
            break
        }
    }
    
    // MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

// MARK: - Collection view methods(data source/delegate)
extension ItemDetailsVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell {
            cell.configureCell(imageUrl: item.images[indexPath.row])
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInsets.left
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Hi there, my index is: \(indexPath.item)")
    }
    
}
