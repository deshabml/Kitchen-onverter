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
    @Persisted var ingredients: List<ProductRecipe>
    @Persisted var cookingMethod: String
    @Persisted var dish: String

    convenience init(name: String, Image: Data,ingredientsList: List<ProductRecipe>, cookingMethod: String, dish: String) {
        self.init()
        self.name = name
        self.Image = Image
        self.ingredients = ingredients
        self.cookingMethod = cookingMethod
        self.dish = dish
    }

    convenience init(name: String, _ ingredients: [ProductRecipe], cookingMethod: String, dish: String) {
        self.init()
        self.name = name
        self.ingredients.append(objectsIn: ingredients)
        self.cookingMethod = cookingMethod
        self.dish = dish
    }

    convenience init(name: String, Image: Data, _ ingredients: [ProductRecipe], cookingMethod: String, dish: String) {
        self.init()
        self.name = name
        self.Image = Image
        self.ingredients.append(objectsIn: ingredients)
        self.cookingMethod = cookingMethod
        self.dish = dish
    }
    
}
