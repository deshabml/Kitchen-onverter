//
//  IngredientListViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 05.05.2023.
//

import Foundation

class IngredientListViewModel: ObservableObject {

    @Published var recordedIngredient: [ProductRecipe] = []
    var completion: ((ProductRecipe)->())!

    func setupRecordedIngredient(_ recordedIngredient: [ProductRecipe]) {
        self.recordedIngredient = recordedIngredient
    }
    
    func setupCompletion(completion: @escaping (ProductRecipe)->()) {
        self.completion = completion
    }
    
}
