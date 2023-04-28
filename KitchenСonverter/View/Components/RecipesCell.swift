//
//  RecipesCell.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 26.04.2023.
//

import SwiftUI

struct RecipesCell: View {

    @Binding var recipe: Recipe

    var body: some View {
        VStack() {
            if let image = UIImage(data: recipe.Image) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(.white)
                    .frame(width: 80, height: 80)
                    .cornerRadius(16)
                    .shadow(color: .white, radius: 10)
            } else {
                Image("RecipeIcons")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .frame(width: 80, height: 80)
                    .cornerRadius(16)
            }
            Spacer()
            Text("\(recipe.name)")
        }
        .font(.custom("AvenirNext", size: CGFloat(16)))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(.yellow.opacity(0.8))
        .cornerRadius(32)
    }
}
