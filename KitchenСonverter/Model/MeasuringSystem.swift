//
//  MeasuringSystem.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//

import Foundation

class MeasuringSystem: Identifiable {
    let id: String
    var title: String


    init(title: String) {
        self.id = UUID().uuidString
        self.title = title
    }
}
