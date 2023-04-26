//
//  RecipesViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 25.04.2023.
//

import Foundation

class RecipesViewModel: ObservableObject {

    @Published var recipes: [Recipe] = []
    @Published var recipesPicker: [Recipe] = []
    @Published var dishPicker: Dish = .all {
        willSet {
            switch newValue {
                case .all:
                    recipesPicker = recipes
                case .first:
                    recipesPicker = recipes.filter { $0.dish == Dish.first.description }
                case .Second:
                    recipesPicker = recipes.filter { $0.dish == Dish.Second.description }
                case .Hot:
                    recipesPicker = recipes.filter { $0.dish == Dish.Hot.description }
                case .Salads:
                    recipesPicker = recipes.filter { $0.dish == Dish.Salads.description }
                case .Snacks:
                    recipesPicker = recipes.filter { $0.dish == Dish.Snacks.description }
            }
        }
    }

    func getData() {
        recipes = RealmService.shared.getRecipes()
        dishPicker = dishPicker
    }
}
