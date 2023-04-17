//
//  TypeMeasuringSystem.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 15.04.2023.
//

import Foundation

struct TypeMeasuringSystem: Identifiable, Hashable {

    var id = UUID().uuidString
    let name: String
    let isWeight: Bool

}
