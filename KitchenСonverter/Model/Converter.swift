//
//  Converter.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//

import Foundation

class Converter: Identifiable {

    let id: String
    let productName: String
    let itog: String
    let measuringSystem: MeasuringSystem

    init(productName: String, itog: String, measuringSystem: MeasuringSystem) {
        self.id = UUID().uuidString
        self.productName = productName
        self.itog = itog
        self.measuringSystem = measuringSystem
    }
    
}
