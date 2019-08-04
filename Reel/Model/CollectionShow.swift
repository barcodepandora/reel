//
//  CollectionShow.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 8/3/19.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import Foundation
import RealmSwift

class CollectionShow: Object {
    @objc dynamic var collection = "RLMArray<Show>()"
    
    override var description: String { return "Popular" }
}

