//
//  RecipesGridViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 05.05.2023.
//

import Foundation

class RecipesGridViewModel: ObservableObject {

    @Published var nameDishPicker: String = ""
    @Published var recipesPicker: [Recipe] = []

    func setupNameDishPicker(_ nameDishPicker: String) {
        self.nameDishPicker = nameDishPicker
    }

    func setupRecipesPicker(_ recipesPicker: [Recipe]) {
        self.recipesPicker = recipesPicker
    }
    
}

extension RecipesGridViewModel {

    func declinationTheText(_ number: Int, _ textOne: String,_ textTwo: String,_ textThree: String) -> String {
        let nubmerTemp = number % 10
        return nubmerTemp == 1 ? textOne : nubmerTemp >= 5 || nubmerTemp == 0 || (11...19).contains(number) ? textTwo : textThree
    }

}
