//
//  DishPicker.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 26.04.2023.
//

import SwiftUI

struct DishPicker: View {

    @StateObject var viewModel: DishPickerViewModel
    @Binding var showAddDish: Bool
    @Binding var showDeleteDish: Bool

    var body: some View {
        VStack {
            ZStack {
                if showAddDish || showDeleteDish {
                    Text(showAddDish ? viewModel.dishTextFild : viewModel.dishPicker.name)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.black.opacity(0.5))
                } else {
                    Picker("Группы", selection: $viewModel.dishPicker) {
                        ForEach(viewModel.isEdit ? viewModel.dishs.filter { $0.name != "Все" } : viewModel.dishs) { dish in
                            Text(dish.name).tag(dish)
                                .foregroundColor(.white)
                        }
                    }
                    .pickerStyle(.wheel)
                    .background(.black.opacity(0.5))
                }
                VStack {
                    HStack {
                        Button {
                            if showDeleteDish {
                                showDeleteDish.toggle()
                            } else {
                                showAddDish.toggle()
                                viewModel.dishTextFild = ""
                            }
                        } label: {
                            Image(systemName: showAddDish || showDeleteDish ? "arrow.turn.up.left" : "plus")
                        }
                        Spacer()
                        if showAddDish || showDeleteDish {
                            Button {
                                if showDeleteDish {
                                    if viewModel.completionUpdate() {
                                        showDeleteDish.toggle()
                                    }
                                } else {
                                    viewModel.completionAdd()
                                    showAddDish.toggle()
                                }
                            } label: {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                    .padding(.vertical, 10)
                    Spacer()
                    if !showAddDish && !showDeleteDish, viewModel.dishPicker.name != "Все", !viewModel.isEdit {
                        HStack {
                            Button {
                                showDeleteDish.toggle()
                                viewModel.setupDishTextFild()
                            } label: {
                                Image(systemName: "square.and.pencil")
                            }
                            Spacer()
                        }
                        .padding(.vertical, 10)
                    }
                }
                .foregroundColor(.green)
                .font(.headline)
                .padding(.horizontal, 10)
            }
            if showAddDish || showDeleteDish {
                ZStack {
                    TextField("Название", text: $viewModel.dishTextFild)
                        .padding()
                        .background(.white)
                    HStack {
                        Spacer()
                        if showDeleteDish {
                            Button {
                                viewModel.completionDelete()
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .frame(width: 150, height: 100)
        .cornerRadius(18, corners: [.topRight, .bottomRight])
    }

}
