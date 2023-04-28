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
                        viewModel.saveRecipe(viewModel: mainViewModel)
                        dismiss()
                    }
                }, isCancelStyle: true)
            }
            if !isViewer {
                GeometryReader { proxy in
                    ScrollView {
                        MainText(text: isEdit ? "Изменение рецепта:" : "Добавление рецепта:",
                                 size: 30,
                                 isClassic: false)
                        MainTextFild(placeHolder: "Введите название блюда",
                                     productQuantity: $viewModel.racipeName,
                                     axis: .horizontal)
                        HStack {
                            VStack {
                                MainText(text: "Группа:",
                                         isClassic: false)
                                DishPicker(dishs: $mainViewModel.dishs,
                                           dishPicker: $mainViewModel.dishPicker,
                                           showAddDish: $showAddDish,
                                           showDeleteDish: $showDeleteDish,
                                           dishTextFild: $mainViewModel.dishTextFild,
                                           isEdit: true, completionAdd: {
                                    mainViewModel.savingDish()
                                }, completionUpdate: {
                                    mainViewModel.updateDish()
                                }, completionDelete: {
                                    showDeleteDishAlert.toggle()
                                })
                                .cornerRadius(18)
                            }
                            Spacer()
                            PhotoPickerRecipe(selectedPhoto: $viewModel.selectedPhoto,
                                              imageForPresentation: viewModel.imageForPresentation)
                        }
                        MainText(text: "Ингредиенты:",
                                 isClassic: false)
                        VStack {
                            HStack {
                                MainTextFild(placeHolder: "Введите название",
                                             productQuantity: $viewModel.ingredientsName,
                                             axis: .horizontal)
                                    .frame(width: 200)
                                MainTextFild(placeHolder: "Количесство",
                                             productQuantity: $viewModel.ingredientsAmount,
                                             axis: .horizontal)
                                MainTextFild(placeHolder: "Ед. изм.",
                                             productQuantity: $viewModel.ingredientsMeasuringSystem,
                                             axis: .horizontal)

                            }
                            MainButton(text: "Добавить ингредиент", colors: (.black, .yellow)) {
                                viewModel.saveIngredient()
                            }
                        }
                        IngredientList(recordedIngredient: $viewModel.ingredients) { productRecipe in
                            viewModel.deleteIngredient(product: productRecipe)
                        }
                        .frame(width: proxy.size.width - 36, height: 150, alignment: .center)
                        MainText(text: "Способ приготовления:",
                                 isClassic: false)
                        MainTextFild(placeHolder: "Способ приготовления",
                                     productQuantity: $viewModel.cookingMethod,
                                     axis: .vertical)
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
        .modifier(AlertElement(TextFirst: mainViewModel.dishTextAlert,
                               switchAlertFirst: $mainViewModel.showCoincidenceAlert,
                               TextSecond: "Вы уверены, что хотите удалить группу \"\(mainViewModel.dishPicker.name)\"?",
                               switchAlertSecond: $showDeleteDishAlert, complitionAlertSecond: {
            if mainViewModel.deleteDish() {
                showDeleteDish.toggle()
            }
        }))
        .animation(.linear(duration: 0.2), value: isViewer)
    }

}
