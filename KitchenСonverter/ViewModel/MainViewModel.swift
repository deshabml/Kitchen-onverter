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
    @Published var measuringSystemPickerFirst: MeasuringSystem = MeasuringSystem(name: "Г", isWeight: true, ratio: 1)
    @Published var measuringSystemPickerSecond: MeasuringSystem = MeasuringSystem(name: "Г", isWeight: true, ratio: 1)
    @Published var measuringSystems: [MeasuringSystem] = []
    @Published var products: [Product] = []

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

extension MainViewModel {

    func getAllData() {
        getAllProducts()
        getAllMeasuringSystem()
        getAllConverters()
    }

    func savingConverter() {
        RealmService.shared.createConverter(converter: Converter(product: productPicker, itog: itog, measuringSystem: measuringSystemPickerSecond))
        getAllConverters()
    }

    func getAllConverters() {
        recordedConverters = RealmService.shared.getConverter()
    }

    func deleteConverters(converter: Converter) {
        RealmService.shared.deleteConverter(converter: converter)
        getAllConverters()
    }

    func savingProduct(product: Product) {
        RealmService.shared.createProduct(product: product)
        getAllProducts()
    }

    func getAllProducts() {
        products = RealmService.shared.getProduct()
    }

    func savingMeasuringSystem(measuringSystem: MeasuringSystem) {
        RealmService.shared.createMeasuringSystem(measuringSystem: measuringSystem)
        getAllMeasuringSystem()
    }

    func getAllMeasuringSystem() {
        measuringSystems = RealmService.shared.getMeasuringSystem()
    }

    func initialFillingDataBase() {
        let firstLaunch = RealmService.shared.getFirstLaunch()
        guard firstLaunch.isEmpty else { return }
        RealmService.shared.createFirstLaunch(firstLaunch: FirstLaunch())
        let startMeasuringSystems: [MeasuringSystem] = [MeasuringSystem(name: "Г", isWeight: true, ratio: 1),
                                                       MeasuringSystem(name: "Кг", isWeight: true, ratio: 1000),
                                                       MeasuringSystem(name: "Л", isWeight: false, ratio: 1000),
                                                       MeasuringSystem(name: "Мл", isWeight: false, ratio: 1),
                                                       MeasuringSystem(name: "Унция", isWeight: true, ratio: 31.1034768),
                                                       MeasuringSystem(name: "Фут", isWeight: true, ratio: 453.59237),
                                                       MeasuringSystem(name: "Стакан", isWeight: false, ratio: 200)]
        startMeasuringSystems.forEach { measuringSystems in
            RealmService.shared.createMeasuringSystem(measuringSystem: measuringSystems)
        }
        let startProducts: [Product] = [Product(name: "Вода", density: 1),
                                              Product(name: "Гречка", density: 0.85),
                                              Product(name: "Рис", density: 0.9),
                                              Product(name: "Cоль", density: 0.9),
                                              Product(name: "Сахар", density: 1.587),
                                              Product(name: "Мука", density: 0.68)]
        startProducts.forEach { product in
            RealmService.shared.createProduct(product: product)
        }
        print("ПЕРВЫЙ ЗАПУСК")
    }

}

