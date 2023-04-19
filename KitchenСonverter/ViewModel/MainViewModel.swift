//
//  MainViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 13.04.2023.
//

import Foundation

class MainViewModel: ObservableObject {

    @Published var recordedConverters: [Converter] = []
    @Published var measuringSystems: [MeasuringSystem] = []
    @Published var products: [Product] = []
    @Published var productQuantity: String = ""
    @Published var itog: String = "0,000000"
    @Published var productPicker: Product = Product()
    @Published var measuringSystemPickerFirst: MeasuringSystem = MeasuringSystem()
    @Published var measuringSystemPickerSecond: MeasuringSystem = MeasuringSystem()
    var isEditScreen = false

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
        recordedConverters = RealmService.shared.getConverter()
        measuringSystems = RealmService.shared.getMeasuringSystem()
        products = RealmService.shared.getProduct()
    }

    func getStartPickerData() {
        productPicker = RealmService.shared.getProduct()[0]
        measuringSystemPickerFirst = RealmService.shared.getMeasuringSystem()[0]
        measuringSystemPickerSecond = RealmService.shared.getMeasuringSystem()[0]
    }

    func savingConverter() {
        RealmService.shared.createObject(object: Converter(product: productPicker, itog: itog, measuringSystem: measuringSystemPickerSecond))
        getAllData()
    }

    func savingObject<T>(object: T) {
        RealmService.shared.createObject(object: object)
        getAllData()
    }

    func updateObject<T>(oldObject: T, newObject: T) {
        RealmService.shared.updateObject(oldObject: oldObject, newObject: newObject)
        getAllData()
    }

    func deleteObject<T>(object: T) {
        RealmService.shared.deleteObject(object: object)
        getAllData()
    }

    func initialFillingDataBase() {
        let firstLaunch = RealmService.shared.getFirstLaunch()
        guard firstLaunch.isEmpty else { return }
        RealmService.shared.createObject(object: FirstLaunch())
        let startMeasuringSystems: [MeasuringSystem] = [MeasuringSystem(name: "Г", isWeight: true, ratio: 1),
                                                       MeasuringSystem(name: "Кг", isWeight: true, ratio: 1000),
                                                       MeasuringSystem(name: "Л", isWeight: false, ratio: 1000),
                                                       MeasuringSystem(name: "Мл", isWeight: false, ratio: 1),
                                                       MeasuringSystem(name: "Унция", isWeight: true, ratio: 31.1034768),
                                                       MeasuringSystem(name: "Фут", isWeight: true, ratio: 453.59237),
                                                       MeasuringSystem(name: "Стакан", isWeight: false, ratio: 200)]
        startMeasuringSystems.forEach { measuringSystems in
            RealmService.shared.createObject(object: measuringSystems)
        }
        let startProducts: [Product] = [Product(name: "Вода", density: 1),
                                              Product(name: "Гречка", density: 0.85),
                                              Product(name: "Рис", density: 0.9),
                                              Product(name: "Cоль", density: 0.9),
                                              Product(name: "Сахар", density: 1.587),
                                              Product(name: "Мука", density: 0.68)]
        startProducts.forEach { product in
            RealmService.shared.createObject(object: product)
        }
        let startTypeMeasuringSystem: [TypeMeasuringSystem] = [TypeMeasuringSystem(name: "Вес", isWeight: true),
                                                          TypeMeasuringSystem(name: "Объём", isWeight: false)]
        startTypeMeasuringSystem.forEach { typeMeasuringSystem in
            RealmService.shared.createObject(object: typeMeasuringSystem)
        }
        print("ПЕРВЫЙ ЗАПУСК")
    }
    
}

