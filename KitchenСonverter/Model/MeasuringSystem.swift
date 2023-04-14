//
//  MeasuringSystem.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//

import Foundation

struct MeasuringSystem: Identifiable, Hashable {

    var id = UUID().uuidString
    let name: String
    let fullName: String
    let isWeight: Bool
    let ratio: Double

}
