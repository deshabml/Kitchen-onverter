//
//  RecipesView.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 21.04.2023.
//

import SwiftUI

struct RecipesView: View {
    
    @StateObject var viewModel = RecipesViewModel()
    @State var showAddDish = false
    @State var showDeleteDish = false
    @State var showDeleteDishAlert = false
    
    var body: some View {
        ZStack {
            RecipesGrid(recipes: $viewModel.recipesPicker,
                        dishPicker: $viewModel.dishPicker,
                        recipesPicker: $viewModel.recipesPicker, viewModel: viewModel)
            VStack {
                HStack() {
                    Spacer()
                    NavigationLink {
                        AddRecipesView(isEdit: false, isViewer: false)
                            .environmentObject(viewModel)
                    } label: {
                        AddButton()
                    }
                }
                Spacer()
            }
            VStack {
                Spacer()
                HStack {
                    DishPicker(dishs: $viewModel.dishs,
                               dishPicker: $viewModel.dishPicker,
                               showAddDish: $showAddDish,
                               showDeleteDish: $showDeleteDish,
                               dishTextFild: $viewModel.dishTextFild,
                               isEdit: false, completionAdd: {
                        viewModel.savingDish()
                    }, completionUpdate: {
                        viewModel.updateDish()
                    }, completionDelete: {
                        showDeleteDishAlert.toggle()
                    })
                    Spacer()
                }
                .padding(.vertical, 150)
            }
        }
        .modifier(BackgroundElement(ImageName: "RecipesBackgraund", onApperComplition: {
            viewModel.loadingScreen()
        }))
        .modifier(AlertElement(TextFirst: viewModel.dishTextAlert,
                               switchAlertFirst: $viewModel.showCoincidenceAlert,
                               TextSecond: "Вы уверены, что хотите удалить группу \"\(viewModel.dishPicker.name)\"?",
                               switchAlertSecond: $showDeleteDishAlert, complitionAlertSecond: {
            if viewModel.deleteDish() {
                showDeleteDish.toggle()
            }
        }))
        .animation(.easeInOut(duration: 0.3), value: showAddDish)
        .animation(.easeInOut(duration: 0.3), value: showDeleteDish)
        .animation(.linear(duration: 0.2), value: viewModel.dishPicker)
    }
    
}
