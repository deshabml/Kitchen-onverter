//
//  RecipesGrid.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 26.04.2023.
//

import SwiftUI

struct RecipesGrid: View {

    @Binding var recipes: [Recipe]
//    @Binding var search: String

    var columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            GeometryReader { proxy in
                LazyVGrid(columns: columns, spacing: 10) {
//                    Section("Рецепты:") {
                        ForEach(0 ..< $recipes.count, id: \.self) { index in
                            NavigationLink {
                                AddProductView(isEdit: false)
                            } label: {
                                RecipesCell(recipe: $recipes[index])
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 5)
                            }
//                            .searchable(text: $search)
                        }
//                    }
//                    .foregroundColor(.white)
//                    .font(.custom("AvenirNext-Bold", size: CGFloat(24)))
                }
//                .searchable(text: $search)
//                .padding(.horizontal, 16)
            }
        }
    }
}

