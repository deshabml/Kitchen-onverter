//
//  RealmService.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 17.04.2023.
//

import Foundation
import RealmSwift

class RealmService {

    static let shared = RealmService()
    private let dataBase = try! Realm()

    private init() { }

    func createFirstLaunch(firstLaunch: FirstLaunch) {
        do {
            try dataBase.write {
                dataBase.add(firstLaunch)
            }
        } catch {
            print("Неисправность базы данных")
        }
    }

    func getFirstLaunch() -> [FirstLaunch] {
        let firstLaunchList = dataBase.objects(FirstLaunch.self)
        var firstLaunchs = [FirstLaunch]()
        for firstLaunch in firstLaunchList {
            firstLaunchs.append(firstLaunch)
        }
        return firstLaunchs
    }

    func createConverter(converter: Converter) {
        do {
            try dataBase.write {
                dataBase.add(converter)
            }
        } catch {
            print("Неисправность базы данных")
        }
    }

    func getConverter() -> [Converter] {
        let converterList = dataBase.objects(Converter.self)
        var converters = [Converter]()
        for converter in converterList {
            converters.append(converter)
        }
        return converters
    }

    func deleteConverter(converter: Converter) {
        do {
            try dataBase.write {
                dataBase.delete(converter)
            }
        } catch {
            print("Неисправность базы данных")
        }
    }

    func createProduct(product: Product) {
        do {
            try dataBase.write {
                dataBase.add(product)
            }
        } catch {
            print("Неисправность базы данных")
        }
    }

    func getProduct() -> [Product] {
        let productList = dataBase.objects(Product.self)
        var products = [Product]()
        for product in productList {
            products.append(product)
        }
        return products
    }

    func createMeasuringSystem(measuringSystem: MeasuringSystem) {
        do {
            try dataBase.write {
                dataBase.add(measuringSystem)
            }
        } catch {
            print("Неисправность базы данных")
        }
    }

    func getMeasuringSystem() -> [MeasuringSystem] {
        let measuringSystemList = dataBase.objects(MeasuringSystem.self)
        var measuringSystems = [MeasuringSystem]()
        for measuringSystem in measuringSystemList {
            measuringSystems.append(measuringSystem)
        }
        return measuringSystems
    }
    
}
