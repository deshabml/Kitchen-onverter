//
//  RecipesGrid.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 26.04.2023.
//

import SwiftUI

struct RecipesGrid: View {

    @Binding var recipes: [Recipe]
    @Binding var dishPicker: Dish
    @Binding var recipesPicker: [Recipe]
    var viewModel: RecipesViewModel

    var columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            GeometryReader { proxy in
                LazyVGrid(columns: columns, spacing: 10) {
                    Section {
                        ForEach(0 ..< $recipes.count, id: \.self) { index in
                            NavigationLink {
                                AddRecipesView(isEdit: false, isUpdate: true, isViewer: true, recipePicker: recipes[index])
                                    .environmentObject(viewModel)
                            } label: {
                                RecipesCell(recipe: $recipes[index])
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 5)
                            }
                        }
                    } header: {
                        HStack {
                            Text("В группе \"\(dishPicker.name)\" \(recipesPicker.count) " + declinationTheText(recipesPicker.count, "рецепт", "рецептов", "рецепта"))
                                .foregroundColor(.white)
                                .modifier(SettingsElement(verticalPadding: 8,
                                                          backgroundColor: .black.opacity(0.5),
                                                          cornerRadius: 8))
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }

}

extension RecipesGrid {

    func declinationTheText(_ number: Int, _ textOne: String,_ textTwo: String,_ textThree: String) -> String {
        let nubmerTemp = number % 10
        return nubmerTemp == 1 ? textOne : nubmerTemp >= 5 || nubmerTemp == 0 || (11...19).contains(number) ? textTwo : textThree
    }

}
