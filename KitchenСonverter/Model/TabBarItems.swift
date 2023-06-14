//
//  TabBarItems.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 21.04.2023.
//

import Foundation

enum TabBarItems: Int, CaseIterable {

    case сalculator = 0
    case recipes = 1

    var title: String{
        switch self {
        case .сalculator:
            return "Калькулятор"
        case .recipes:
            return "Рецепты"
        }
    }
    
    var iconName: String{
        switch self {
        case .сalculator:
            return "TabBarCalc"
        case .recipes:
            return "TabBarRec"
        }
    }
    
}
