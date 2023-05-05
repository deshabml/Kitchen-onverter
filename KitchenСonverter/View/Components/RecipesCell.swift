//
//  RecipesCell.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 26.04.2023.
//

import SwiftUI

struct RecipesCell: View {

    var recipe: Recipe

    var body: some View {
        VStack() {
            ImageRecipe(viewModel: ImageRecipeViewModel(recipe: recipe),
                        size: 80)
            Spacer()
            Text("\(recipe.name)")
        }
        .font(.custom("AvenirNext", size: CGFloat(16)))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(SettingsElement(backgroundColor: .yellow.opacity(0.8), cornerRadius: 32))
    }
    
}
