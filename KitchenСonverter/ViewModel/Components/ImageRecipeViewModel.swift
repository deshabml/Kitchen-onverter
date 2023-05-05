//
//  ImageRecipeViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 05.05.2023.
//

import Foundation

class ImageRecipeViewModel: ObservableObject {

    @Published var recipe: Recipe

    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
}
