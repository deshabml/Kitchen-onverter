//
//  TypeMeasuringSystem.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 15.04.2023.
//

import Foundation
import RealmSwift

class TypeMeasuringSystem: Object, Identifiable {

    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var name: String
    @Persisted var isWeight: Bool

    convenience init(name: String, isWeight: Bool) {
        self.init()
        self.name = name
        self.isWeight = isWeight
    }

}

