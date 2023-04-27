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

    func createObject<T>(object: T) {
        guard let object = object as? Object else { return }
        do {
            try dataBase.write {
                dataBase.add(object)
            }
        } catch {
            print("Неисправность базы данных")
        }
    }

    func updateObject<T>(oldObject: T, newObject: T) {
        if let oldObject = oldObject as? MeasuringSystem, let newObject = newObject as? MeasuringSystem {
            do {
                try dataBase.write {
                    oldObject.name = newObject.name
                    oldObject.ratio = newObject.ratio
                    oldObject.isWeight = newObject.isWeight
                }
            } catch {
                print("Неисправность базы данных")
            }
        }
        if let oldObject = oldObject as? Product, let newObject = newObject as? Product {
            do {
                try dataBase.write {
                    oldObject.name = newObject.name
                    oldObject.density = newObject.density
                }
            } catch {
                print("Неисправность базы данных")
            }
        }
        if let oldObject = oldObject as? Recipe, let newObject = newObject as? Recipe {
            do {
                try dataBase.write() {
                    oldObject.name = newObject.name
                    oldObject.Image = newObject.Image
                    oldObject.ingredients = newObject.ingredients
                    oldObject.cookingMethod = newObject.cookingMethod
                    oldObject.dish = newObject.dish
                }
            } catch {
                print("Неисправность базы данных")
            }
        }
        if let oldObject = oldObject as? Dish, let newObject = newObject as? Dish {
            do {
                try dataBase.write {
                    oldObject.name = newObject.name
                }
            } catch {
                print("Неисправность базы данных")
            }
        }
    }

    func deleteObject<T>(object: T) {
        guard let object = object as? Object else { return }
        do {
            try dataBase.write {
                dataBase.delete(object)
            }
        } catch {
            print("Неисправность базы данных")
        }
    }
    
}

extension RealmService {

    func getFirstLaunch() -> [FirstLaunch] {
        let firstLaunchList = dataBase.objects(FirstLaunch.self)
        var firstLaunchs = [FirstLaunch]()
        for firstLaunch in firstLaunchList {
            firstLaunchs.append(firstLaunch)
        }
        return firstLaunchs
    }

    func getConverter() -> [Converter] {
        let converterList = dataBase.objects(Converter.self)
        var converters = [Converter]()
        for converter in converterList {
            converters.append(converter)
        }
        return converters
    }

    func getProduct() -> [Product] {
        let productList = dataBase.objects(Product.self)
        var products = [Product]()
        for product in productList {
            products.append(product)
        }
        return products
    }

    func getMeasuringSystem() -> [MeasuringSystem] {
        let measuringSystemList = dataBase.objects(MeasuringSystem.self)
        var measuringSystems = [MeasuringSystem]()
        for measuringSystem in measuringSystemList {
            measuringSystems.append(measuringSystem)
        }
        return measuringSystems
    }

    func getTypeMeasuringSystem() -> [TypeMeasuringSystem] {
        let typeMeasuringSystemList = dataBase.objects(TypeMeasuringSystem.self)
        var typeMeasuringSystems = [TypeMeasuringSystem]()
        for typeMeasuringSystem in typeMeasuringSystemList {
            typeMeasuringSystems.append(typeMeasuringSystem)
        }
        return typeMeasuringSystems
    }

    func getRecipes() -> [Recipe] {
        let recipeList = dataBase.objects(Recipe.self)
        var recipes = [Recipe]()
        for recipe in recipeList {
            recipes.append(recipe)
        }
        return recipes
    }

    func getDishs() -> [Dish] {
        let dishList = dataBase.objects(Dish.self)
        var dishs = [Dish]()
        for dish in dishList {
            dishs.append(dish)
        }
        return dishs
    }

}


