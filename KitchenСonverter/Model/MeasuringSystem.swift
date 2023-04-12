//
//  MeasuringSystem.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//

import Foundation

enum MeasuringSystem: String, CaseIterable, Identifiable {

    case gram = "Г"
    case kilogram = "Кг"
    case liter = "Л"
    case milliliter = "Мл"
    case ounce = "У"
    case food = "Ф"

    var id: String { rawValue }

}
