//
//  Dish.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 26.04.2023.
//

import Foundation

enum Dish: Int, CaseIterable {

    case all = 0
    case first = 1
    case Second = 2
    case Hot = 3
    case Salads = 4
    case Snacks = 5

    init(type: Int) {
        switch type {
            case 0: self = .all
            case 1: self = .first
            case 2: self = .Second
            case 3: self = .Hot
            case 4: self = .Salads
            case 5: self = .Snacks
            default: self = .all
        }
    }

    var description: String {
        switch self {
            case .all: return "Все"
            case .first: return "Первое"
            case .Second: return "Второе"
            case .Hot: return "Горячее"
            case .Salads: return "Салаты"
            case .Snacks: return "Закуски"
        }
    }

}
