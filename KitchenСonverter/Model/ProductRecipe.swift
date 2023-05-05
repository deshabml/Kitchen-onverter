//
//  ProductRecipe.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 25.04.2023.
//

import Foundation
import RealmSwift

class ProductRecipe: Object, Identifiable {

    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var name: String
    @Persisted var amount: String
    @Persisted var measuringSystem: String

    convenience init(name: String, amount: String, measuringSystem: String) {
        self.init()
        self.name = name
        self.amount = amount
        self.measuringSystem = measuringSystem
    }

}
