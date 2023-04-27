//
//  Dish.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 26.04.2023.
//

import Foundation
import RealmSwift

class Dish: Object, Identifiable {

    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var name: String

    convenience init(name: String) {
        self.init()
        self.name = name
    }

}
