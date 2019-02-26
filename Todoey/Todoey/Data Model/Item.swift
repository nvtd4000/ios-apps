//
//  Item.swift
//  Todoey
//
//  Created by Dung Nguyen on 2/25/19.
//  Copyright © 2019 dapp. All rights reserved.
//

import Foundation
import RealmSwift

class Item:Object{
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
