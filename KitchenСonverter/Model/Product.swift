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
//    @Persisted var amount: String
//    @Persisted var measuringSystem: MeasuringSystem?

    convenience init(name: String, density: Double) {
        self.init()
        self.name = name
        self.density = density
    }

//    convenience init(name: String, amount: String, measuringSystem: MeasuringSystem) {
//        self.init()
//        self.name = name
//        self.amount = amount
//        self.measuringSystem = measuringSystem
//    }

}


