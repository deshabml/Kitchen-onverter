//
//  Converter.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//

import Foundation

class Converter: Identifiable {

    let id: String
    let product: Product
    let itog: String
    let measuringSystem: MeasuringSystem

    init(product: Product, itog: String, measuringSystem: MeasuringSystem) {
        self.id = UUID().uuidString
        self.product = product
        self.itog = itog
        self.measuringSystem = measuringSystem
    }
    
}
