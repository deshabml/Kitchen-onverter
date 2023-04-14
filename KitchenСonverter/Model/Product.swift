//
//  Product.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//
//
import Foundation

struct Product: Identifiable, Hashable {

    let id = UUID().uuidString
    let name: String
    let density: Double

}

