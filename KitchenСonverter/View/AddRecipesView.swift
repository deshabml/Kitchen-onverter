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
    @StateObject var viewModel = AddRecipesViewModel()
    @State var showAddDish = false
    @State var showDeleteDish = false
    @State var showDeleteDishAlert = false
    let isEdit: Bool
    @State var isViewer: Bool
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                AddViewButton(text: "Отмена", colors: (.black, .white), completion: {
                    dismiss()
                })
                Spacer()
                AddViewButton(text: isViewer ? "Изменить" : "Coхранить", colors: isViewer ? (.black, .yellow) : (.white, .green), completion: {
                    if isViewer {
                        self.isViewer.toggle()
                    } else {
                        viewModel.saveRecipe(viewModel: mainViewModel)
                        dismiss()
                    }
                })
            }
            if !isViewer {
                GeometryReader { proxy in
                    ScrollView {
                        AddViewText(text: isEdit ? "Изменение рецепта:" : "Добавление рецепта:", size: 30)
                        MainTextFild(placeHolder: "Введите название блюда", productQuantity: $viewModel.racipeName)
                        HStack {
                            VStack {
                                AddViewText(text: "Группа:", size: 24)
                                DishPicker(dishs: $mainViewModel.dishs,
                                           dishPicker: $mainViewModel.dishPicker,
                                           showAddDish: $showAddDish,
                                           showDeleteDish: $showDeleteDish,
                                           dishTextFild: $mainViewModel.dishTextFild,
                                           isEdit: true,
                                           completionAdd: {
                                    mainViewModel.savingDish()
                                },
                                           completionUpdate: {
                                    mainViewModel.updateDish()
                                },
                                           completionDelete: {
                                    showDeleteDishAlert.toggle()
                                })
                                .cornerRadius(18)
                            }
                            Spacer()
                            PhotosPicker(selection: $viewModel.selectedPhoto, matching: .images) {
                                viewModel.imageForPresentation
                                    .resizable()
                                    .scaledToFill()
                                    .foregroundColor(.green)
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(18)
                                    .shadow(color: .black, radius: 10)
                            }
                        }
                        AddViewText(text: "Ингредиенты:", size: 24)
                        VStack {
                            HStack {
                                MainTextFild(placeHolder: "Введите название", productQuantity: $viewModel.ingredientsName)
                                    .frame(width: 200)
                                MainTextFild(placeHolder: "Количесство", productQuantity: $viewModel.ingredientsAmount)
                                MainTextFild(placeHolder: "Ед. изм.", productQuantity: $viewModel.ingredientsMeasuringSystem)

                            }
                            MainButton(text: "Добавить ингредиент", colors: (.black, .yellow)) {
                                viewModel.saveIngredient()
                            }
                        }
                        IngredientList(recordedIngredient: $viewModel.ingredients) { productRecipe in
                            viewModel.deleteIngredient(product: productRecipe)
                        }
                        .frame(width: proxy.size.width - 36, height: 150, alignment: .center)
                        AddViewText(text: "Способ приготовления:", size: 24)
                        TextField("Способ приготовления", text: $viewModel.cookingMethod,  axis: .vertical)
                            .lineLimit(5...10)
                            .padding()
                            .background(.white)
                            .cornerRadius(18)
                        Rectangle()
                            .opacity(0)
                            .padding(.vertical, 40)
                    }
                    .padding(.horizontal, 16)
                }
            } else {

            }
        }
        .modifier(BackgroundElement(ImageName: "AddRecipesBackgraund", onApperComplition: {
            if !isViewer {
                mainViewModel.getStartPickerData(index: 1)
            }
        }))
        .modifier(AlertElement(TextFirst: mainViewModel.dishTextAlert, switchAlertFirst: $mainViewModel.showCoincidenceAlert, TextSecond: "Вы уверены, что хотите удалить группу \"\(mainViewModel.dishPicker.name)\"?", switchAlertSecond: $showDeleteDishAlert, complitionAlertSecond: {
            if mainViewModel.deleteDish() {
                showDeleteDish.toggle()
            }
        }))
        .animation(.linear(duration: 0.2), value: isViewer)
    }

}
