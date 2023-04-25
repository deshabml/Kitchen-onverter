//
//  recipe.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 25.04.2023.
//

import Foundation
import RealmSwift

class Recipe: Object, Identifiable {

    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var name: String
    @Persisted var Image: Data
    @Persisted var ingredients: List<Product>
    @Persisted var cookingMethod: String

    convenience init(name: String, ingredients: List<Product>) {
        self.init()
        self.name = name
        self.ingredients = ingredients
    }

    convenience init(name: String, _ ingredients: [Product], cookingMethod: String) {
        self.init()
        self.name = name
        self.ingredients.append(objectsIn: ingredients)
        self.cookingMethod = cookingMethod
    }
    
}
