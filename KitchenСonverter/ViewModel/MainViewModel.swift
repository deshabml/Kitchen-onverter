//
//  MainViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 13.04.2023.
//

import Foundation

class MainViewModel: ObservableObject {

    @Published var recordedConverters: [Converter] = []
    @Published var productQuantity: String = ""
    @Published var itog: String = "0,000000"
    @Published var productPicker: Product = Product(name: "Вода", density: 1)
    @Published var measuringSystemPickerFirst: MeasuringSystem = MeasuringSystem(name: "Грамм", isWeight: true, ratio: 1)
    @Published var measuringSystemPickerSecond: MeasuringSystem = MeasuringSystem(name: "Грамм", isWeight: true, ratio: 1)

    @Published var measuringSystems: [MeasuringSystem] = [MeasuringSystem(name: "Г", isWeight: true, ratio: 1),
                                                          MeasuringSystem(name: "Кг", isWeight: true, ratio: 1000),
                                                          MeasuringSystem(name: "Л", isWeight: false, ratio: 1000),
                                                          MeasuringSystem(name: "Мл", isWeight: false, ratio: 1),
                                                          MeasuringSystem(name: "Унция", isWeight: true, ratio: 31.1034768),
                                                          MeasuringSystem(name: "Фут", isWeight: true, ratio: 453.59237),
                                                          MeasuringSystem(name: "Стакан", isWeight: false, ratio: 200)]
    @Published var products: [Product] = [Product(name: "Вода", density: 1),
                                          Product(name: "Гречка", density: 0.85),
                                          Product(name: "Рис", density: 0.9),
                                          Product(name: "Cоль", density: 0.9),
                                          Product(name: "Сахар", density: 1.587),
                                          Product(name: "Мука", density: 0.68)]

    func savingConverter() {
        recordedConverters.append(Converter(product: productPicker, itog: itog, measuringSystem: measuringSystemPickerSecond))
    }

    func recalculation() {
        guard let productQuantity = Double(productQuantity) else { return }
        let firstPicker = measuringSystemPickerFirst
        let secondPicker = measuringSystemPickerSecond
        var calculation: Double = 0
        if firstPicker.isWeight && secondPicker.isWeight {
            calculation = productQuantity * firstPicker.ratio / secondPicker.ratio
            print(secondPicker.ratio / firstPicker.ratio)
            print(calculation)
        } else if !firstPicker.isWeight && !secondPicker.isWeight {
            calculation = productQuantity * firstPicker.ratio / secondPicker.ratio
        } else if firstPicker.isWeight {
            calculation = productQuantity * firstPicker.ratio / secondPicker.ratio / productPicker.density
        } else {
            calculation = productQuantity * firstPicker.ratio / secondPicker.ratio * productPicker.density
        }
        itog = String(format: "%.6f", calculation)
    }

}

