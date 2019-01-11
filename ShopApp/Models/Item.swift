//
//  Item.swift
//  ShopApp
//
//  Created by Dmytro Dobrovolskyy on 11/7/18.
//  Copyright © 2018 YellowLeaf. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JSONAbleType {
    static func fromJSON(_: [String: Any], withID id: String) -> Self
}

final class Item: NSObject, JSONAbleType {
    let id: String
    let name: String
    let price: Double
    let count: Int
    let categories: [String]
    let images: [String]
    let colors: [String : Int]
    let sizes: [String : Int]
    
    init( id: String = "",
          name: String = "",
          price: Double = 0.0,
          count: Int = 0,
          categories: [String] = [""],
          images: [String] = [""],
          colors: [String : Int] = [:],
          sizes: [String : Int] = [:] )
    {
        self.id = id
        self.name = name
        self.price = price
        self.count = count
        self.categories = categories
        self.images = images
        self.colors = colors
        self.sizes = sizes
    }

    static func fromJSON(_ json:[String: Any], withID id: String) -> Item {
        let json = JSON(json)

        let name = json[id]["name"].stringValue
        
        let price = json[id]["price"].doubleValue
        
        let count = json[id]["count"].intValue
        
        var categories = [String]()
        json[id]["categories"].dictionaryValue.forEach {
            categories.append($0.key)
        }
        
        var images = [String]()
        json[id]["images"].arrayValue.forEach {
            images.append($0.stringValue)
        }
        
        var colors = [String : Int]()
        json[id]["colors"].dictionaryValue.forEach {
            colors[$0.key] = $0.value.intValue
        }
        
        var sizes = [String : Int]()
        json[id]["sizes"].dictionaryValue.forEach {
            sizes[$0.key] = $0.value.intValue
        }
        
        return Item(id: id, name: name, price: price, count: count, categories: categories, images: images, colors: colors, sizes: sizes)
    }
}
