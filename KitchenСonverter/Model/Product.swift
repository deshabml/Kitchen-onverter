//
//  Product.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//

import Foundation

class Product: Identifiable {
    let id: String
    var title: String
    var measuringSystem: MeasuringSystem


    init(title: String, measuringSystem: MeasuringSystem) {
        self.id = UUID().uuidString
        self.title = title
        self.measuringSystem = measuringSystem
    }
}
