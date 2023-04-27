//
//  RecipesGrid.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 26.04.2023.
//

import SwiftUI

struct RecipesGrid: View {

    @Binding var recipes: [Recipe]

    var columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ZStack {
            ScrollView {
                GeometryReader { proxy in
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(0 ..< $recipes.count, id: \.self) { index in
                            NavigationLink {
                                AddProductView(isEdit: false)
                            } label: {
                                RecipesCell(recipe: $recipes[index])
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 5)
                            }
                        }
                    }
                }
            }
        }
    }

}

