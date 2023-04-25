//
//  RecipesGrid.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 26.04.2023.
//

import SwiftUI

struct RecipesGrid: View {

    @Binding var recipes: [Recipe]
    var columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            GeometryReader { proxy in
                LazyVGrid(columns: columns, spacing: 12) {
                    Section("Рецепты:") {
                        ForEach(recipes) { recipe in
                            NavigationLink {
                                AddProductView(isEdit: false)
                            } label: {
                                RecipesCell(recipe: recipe)
                                    .frame(height: proxy.size.width / 2)
                                    .padding(.horizontal, 4)
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .font(.custom("AvenirNext-Bold", size: CGFloat(20)))
                }.padding(8)
            }
        }
    }
}

