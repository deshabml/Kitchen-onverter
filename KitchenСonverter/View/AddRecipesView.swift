//
//  AddRecipesView.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 27.04.2023.
//

import SwiftUI
import PhotosUI

struct AddRecipesView: View {

    @EnvironmentObject var mainViewModel: RecipesViewModel
    @StateObject var viewModel: AddRecipesViewModel
    @State var showAddDish = false
    @State var showDeleteDish = false
    @State var showDeleteAlert = false
    var isEdit: Bool
    var isUpdate: Bool = false
    @State var isViewer: Bool
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                MainButton(text: "Отмена",
                           colors: (.black, .white), completion: {
                    dismiss()
                }, isCancelStyle: true)
                Spacer()
                MainButton(text: isViewer ? "Изменить" : "Coхранить",
                           colors: isViewer ? (.black, .yellow) : (.white, .green), completion: {
                    if isViewer {
                        self.isViewer.toggle()
                    } else {
                        if viewModel.checkRecipe(recipes: mainViewModel.recipes) {
                            if !isUpdate {
                                viewModel.saveRecipe(viewModel: mainViewModel)
                            } else {
                                viewModel.updateRecipe(viewModel: mainViewModel)
                            }
                            dismiss()
                        }
                    }
                }, isCancelStyle: true)
            }
            if !isViewer {
                GeometryReader { proxy in
                    ScrollView(showsIndicators: false) {
                        MainText(text: isEdit ? "Изменение рецепта:" : "Добавление рецепта:",
                                 size: 30,
                                 isClassic: false)
                        MainTextFild(viewModel: viewModel.racipeNameMainTextFildViewModel,
                                     axis: .horizontal)
                        HStack {
                            VStack {
                                MainText(text: "Группа:",
                                         isClassic: false)
                                DishPicker(viewModel: mainViewModel.dishPickerViewModel,
                                           showAddDish: $showAddDish,
                                           showDeleteDish: $showDeleteDish)
                                .cornerRadius(18)
                            }
                            Spacer()
                            PhotoPickerRecipe(viewModel: viewModel.photoPickerRecipeViewModel)
                        }
                        .padding(16)
                        MainText(text: "Ингредиенты:",
                                 isClassic: false)
                        VStack {
                            HStack {
                                MainTextFild(viewModel: viewModel.ingredientsNameMainTextFildViewModel,
                                             axis: .horizontal)
                                    .frame(width: 200)
                                MainTextFild(viewModel: viewModel.ingredientsAmountMainTextFildViewModel,
                                             axis: .horizontal)
                                MainTextFild(viewModel: viewModel.ingredientsMSMainTextFildViewModel,
                                             axis: .horizontal)
                            }
                            MainButton(text: "Добавить ингредиент", colors: (.black, .yellow)) {
                                viewModel.saveIngredient()
                            }
                        }
                        IngredientList(viewModel: viewModel.ingredientListViewModel)
                        .frame(width: proxy.size.width - 36, height: 150, alignment: .center)
                        MainText(text: "Способ приготовления:",
                                 isClassic: false)
                        MainTextFild(viewModel: viewModel.cookingMethodMainTextFildViewModel,
                                     axis: .vertical)
                        if isUpdate {
                            MainButton(text: "Удалить",
                                       colors: (.white, .red)) {
                                showDeleteAlert.toggle()
                            }
                        }
                        Rectangle()
                            .opacity(0)
                            .padding(.vertical, 40)
                    }
                    .padding(.horizontal, 16)
                }
            } else {
                ScrollView(showsIndicators: false) {
                    VStack {
                        MainText(text: viewModel.recipePicker.name,
                                 size: 30,
                                 isClassic: false)
                        if viewModel.checkImage() {
                            ImageRecipe(viewModel: ImageRecipeViewModel(recipe: viewModel.recipePicker),
                                        size: 300)
                        }
                        MainText(text: "В группе: \"\(viewModel.recipePicker.dish)\"",
                                 isClassic: false)
                    }
                    .padding(.horizontal, 16)
                    VStack {
                        MainText(text: viewModel.ingredientsText())
                        Text("Cпособ приготовления:\n\(viewModel.cookingMethodMainTextFildViewModel.bindingProperty)")
                            .foregroundColor(.white)
                            .modifier(SettingsElement(backgroundColor: .black.opacity(0.5)))
                        Spacer()
                            .padding(.vertical, 50)
                    }
                }
            }
        }
        .modifier(BackgroundElement(ImageName: "AddRecipesBackgraund", onApperComplition: {
            viewModel.loadDishPicker(mainViewModel: mainViewModel)
            if isViewer {
                viewModel.dataВistribution(dishs: mainViewModel.dishPickerViewModel.dishs,
                                           mainViewModel: mainViewModel)
            }
        }))
        .modifier(AlertElement(TextFirst: viewModel.errorMasege, switchAlertFirst: $viewModel.IsShowErrorAlert, TextSecond: "Вы уверены, что хотите удалить рецепт?", switchAlertSecond: $showDeleteAlert, complitionAlertSecond: {
            viewModel.deleteRecipe(viewModel: mainViewModel)
            dismiss()
        }))
        .animation(.easeInOut(duration: 0.5), value: isViewer)
    }

}
