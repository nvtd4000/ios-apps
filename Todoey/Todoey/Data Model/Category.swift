//
//  Category.swift
//  Todoey
//
//  Created by Dung Nguyen on 2/25/19.
//  Copyright © 2019 dapp. All rights reserved.
//

import Foundation
import RealmSwift

class Category:Object{
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
