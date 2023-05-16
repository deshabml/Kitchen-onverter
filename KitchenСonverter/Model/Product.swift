//
//  Product.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//
//
import Foundation
import RealmSwift

class Product: Object, Identifiable {

    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var name: String
    @Persisted var density: Double

    convenience init(name: String, density: Double) {
        self.init()
        self.name = name
        self.density = density
    }

}


