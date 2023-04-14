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
    @Published var measuringSystemPickerFirst: MeasuringSystem = MeasuringSystem(name: "Грамм", fullName: "грамм", isWeight: true)
    @Published var measuringSystemPickerSecond: MeasuringSystem = MeasuringSystem(name: "Грамм", fullName: "грамм", isWeight: true)

    

    @Published var measuringSystems: [MeasuringSystem] = [MeasuringSystem(name: "Г", fullName: "грамм", isWeight: true),
                                                          MeasuringSystem(name: "Кг", fullName: "килограмм", isWeight: true),
                                                          MeasuringSystem(name: "Л", fullName: "литр", isWeight: false),
                                                          MeasuringSystem(name: "Мл", fullName: "милилитр", isWeight: false),
                                                          MeasuringSystem(name: "Унция", fullName: "унция", isWeight: true),
                                                          MeasuringSystem(name: "Фут", fullName: "фут", isWeight: true),
                                                          MeasuringSystem(name: "Стакан", fullName: "стакан", isWeight: false)]
    @Published var products: [Product] = [Product(name: "Вода", density: 1),
                                          Product(name: "Гречка", density: 0.85),
                                          Product(name: "Рис", density: 0.9),
                                          Product(name: "Cоль", density: 0.9),
                                          Product(name: "Сахар", density: 1.587),
                                          Product(name: "Мука", density: 0.68)]

    func savingConverter() {
        recordedConverters.append(Converter(productName: productPicker.name, itog: itog, measuringSystem: measuringSystemPickerSecond))
    }

    func recalculation() {
        guard let productQuantity = Double(productQuantity) else { return }
        let calculation = productQuantity * 1000
        itog = "\(calculation)"
    }

}

