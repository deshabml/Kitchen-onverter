//
//  MeasuringSystem.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//

import Foundation
import RealmSwift

class MeasuringSystem: Object, Identifiable {

    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var name: String
    @Persisted var isWeight: Bool
    @Persisted var ratio: Double

    convenience init(name: String, isWeight: Bool, ratio: Double) {
        self.init()
        self.name = name
        self.isWeight = isWeight
        self.ratio = ratio
    }

}
