//
//  DishPicker.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 26.04.2023.
//

import SwiftUI

struct DishPicker: View {

    @Binding var dishs: [Dish]
    @Binding var dishPicker: Dish
    @Binding var showAddDish: Bool
    @Binding var showDeleteDish: Bool
    @Binding var dishTextFild: String
    var isEdit: Bool
    var completionAdd: ()->()
    var completionUpdate: ()->(Bool)
    var completionDelete: ()->()

    var body: some View {
        VStack {
            ZStack {
                if showAddDish || showDeleteDish {
                    Text(showAddDish ? dishTextFild : dishPicker.name)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.black.opacity(0.5))
                } else {
                    Picker("Группы", selection: $dishPicker) {
                        ForEach(isEdit ? dishs.filter { $0.name != "Все" } : dishs) { dish in
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
                                dishTextFild = ""
                            }
                        } label: {
                            Image(systemName: showAddDish || showDeleteDish ? "arrow.turn.up.left" : "plus")
                        }
                        Spacer()
                        if showAddDish || showDeleteDish {
                            Button {
                                if showDeleteDish {
                                    if completionUpdate() {
                                        showDeleteDish.toggle()
                                    }
                                } else {
                                    completionAdd()
                                    showAddDish.toggle()
                                }
                            } label: {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                    .padding(.vertical, 10)
                    Spacer()
                    if !showAddDish && !showDeleteDish, dishPicker.name != "Все" {
                        HStack {
                            Button {
                                showDeleteDish.toggle()
                                dishTextFild = dishPicker.name
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
                    TextField("Название", text: $dishTextFild)
                        .padding()
                        .background(.white)
                    HStack {
                        Spacer()
                        if showDeleteDish {
                            Button {
                                completionDelete()
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
