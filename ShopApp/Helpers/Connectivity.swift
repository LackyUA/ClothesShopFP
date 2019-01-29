//
//  Connectivity.swift
//  ShopApp
//
//  Created by Dmytro Dobrovolskyy on 1/29/19.
//  Copyright © 2019 YellowLeaf. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
