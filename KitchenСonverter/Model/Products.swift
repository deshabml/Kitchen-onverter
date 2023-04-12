//
//  Product.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//
//
import Foundation

enum Products: String, CaseIterable, Identifiable {

    case water = "Вода"
    case buckwheat = "Гречка"
    case rice = "Рис"
    case salt = "Соль"
    case sugar = "Сахар"
    case flour = "Мука"

    var id: String { rawValue }

}
