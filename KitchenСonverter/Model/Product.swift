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

//enum MeasuringSystems: String {
//
//    case gram = "Г"
//    case kilogram = "Кг"
//    case ounce = "У"
//    case pound = "Ф"
//    case liter = "Л"
//    case milliliter = "Мл"
//
////    var id: Int {
////        switch self {
////            case .gram:
////                return 1
////            case .kilogram:
////                return 2
////            case .ounce:
////                return 3
////            case .pound:
////                return 4
////            case .liter:
////                return 5
////            case .milliliter:
////                return 6
////        }
////    }
////    var title: String {
////        self.rawValue
////    }
//}
