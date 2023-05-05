//
//  RecipesGrid.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 26.04.2023.
//

import SwiftUI

struct RecipesGrid: View {

    @StateObject var viewModel: RecipesGridViewModel
    @EnvironmentObject var mainViewModel: RecipesViewModel

    var columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            GeometryReader { proxy in
                LazyVGrid(columns: columns, spacing: 10) {
                    Section {
                        ForEach(viewModel.recipesPicker) { recipes in
                            NavigationLink {
                                AddRecipesView(viewModel: AddRecipesViewModel(recipePicker: recipes),
                                               isEdit: false,
                                               isUpdate: true,
                                               isViewer: true)
                                    .environmentObject(mainViewModel)
                            } label: {
                                RecipesCell(recipe: recipes)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 5)
                            }
                        }
                    } header: {
                        HStack {
                            Text("В группе \"\(viewModel.nameDishPicker)\" \(viewModel.recipesPicker.count) " + viewModel.declinationTheText(viewModel.recipesPicker.count, "рецепт", "рецептов", "рецепта"))
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
