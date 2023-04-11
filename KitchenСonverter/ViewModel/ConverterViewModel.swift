//
//  ConverterViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//

import Foundation

class ConverterViewModel {

    @Published var products: [String] = [
        "Вода",
        "Гречка",
        "Рис",
        "Соль",
        "Сахар",
        "Мука"
    ]
//
//    @Published var products: [Product] = [
//        Product(title: "Вода", measuringSystem: MeasuringSystem(title: "Л")),
//        Product(title: "Гречка", measuringSystem: MeasuringSystem(title: "Г")),
//        Product(title: "Рис", measuringSystem: MeasuringSystem(title: "Г")),
//        Product(title: "Соль", measuringSystem: MeasuringSystem(title: "Г")),
//        Product(title: "Сахар", measuringSystem: MeasuringSystem(title: "Г")),
//        Product(title: "Мука", measuringSystem: MeasuringSystem(title: "Г"))
//    ]
    @Published var measuringSystems: [MeasuringSystem] = [
        MeasuringSystem(title: "Г"),
        MeasuringSystem(title: "Кг"),
        MeasuringSystem(title: "Л"),
        MeasuringSystem(title: "Мл"),
        MeasuringSystem(title: "У"),
        MeasuringSystem(title: "П")
    ]
    @Published var recordedConverters: [Converter] = []

    func addConverter(productName: String, itog: String) {
        recordedConverters.append(Converter(productName: productName, itog: itog))
    }

    func findConverter() {

    }

}
