//
//  Converter.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//

import Foundation
import RealmSwift

class Converter: Object, Identifiable {

    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var product: Product?
    @Persisted var itog: String
    @Persisted var measuringSystem: MeasuringSystem?

    convenience init(product: Product, itog: String, measuringSystem: MeasuringSystem) {
        self.init()
        self.product = product
        self.itog = itog
        self.measuringSystem = measuringSystem
    }
    
}
