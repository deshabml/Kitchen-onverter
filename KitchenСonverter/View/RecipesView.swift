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
        VStack {
            ZStack {
                RecipesGrid(recipes: $viewModel.recipesPicker)
                VStack {
                    Spacer()
                    HStack {
                        DishPicker(dishs: $viewModel.dishs,
                                   dishPicker: $viewModel.dishPicker,
                                   showAddDish: $showAddDish,
                                   showDeleteDish: $showDeleteDish,
                                   dishTextFild: $viewModel.dishTextFild,
                                   completionAdd: {
                            viewModel.savingDish()
                        },
                                   completionUpdate: {
                            viewModel.updateDish()
                        },
                                   completionDelete: {
                            showDeleteDishAlert.toggle()
                        })
                        Spacer()
                    }
                    .padding(.vertical, 150)
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("RecipesBackgraund")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
        )
        .onAppear {
            viewModel.getStartPickerData()
            viewModel.getData()
        }
        .alert(viewModel.dishTextAlert, isPresented: $viewModel.showCoincidenceAlert) {
            Button("ОК") { }
        }
        .alert("Вы уверены, что хотите удалить группу \"\(viewModel.dishPicker.name)\"?", isPresented: $showDeleteDishAlert) {
            Button("ОТМЕНА", role: .cancel) { }
            Button("УДАЛИТЬ", role: .destructive) {
                if viewModel.deleteDish() {
                    showDeleteDish.toggle()
                }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: showAddDish)
        .animation(.easeInOut(duration: 0.3), value: showDeleteDish)
    }

}

//struct RecipesView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            RecipesView()
//        }
//    }
//}
