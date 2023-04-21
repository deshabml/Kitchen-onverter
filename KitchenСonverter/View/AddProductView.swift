//
//  AddProductView.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 15.04.2023.
//

import SwiftUI

struct AddProductView: View {

    @EnvironmentObject var mainViewModel: CalculatorViewModel
    @StateObject var viewModel = AddProductViewModel()
    @State var showAlert = false
    @State var showDeleteAlert = false
    let isEdit: Bool
    @Environment (\.dismiss) var dismiss

    var body: some View {
        VStack {
            HStack {
                AddViewButtonCancell(completion: {
                    dismiss()
                })
                Spacer()
            }
            AddViewText(text: isEdit ? "Изменение" : "Добавление", size: 30)
            AddViewText(text: "продукта:", size: 30)
            MainTextFild(placeHolder: "Введите наименование продукта", productQuantity: $viewModel.productName)
                .padding(.horizontal, 16)
            AddViewText(text: "плотность:", size: 24)
            MainTextFild(placeHolder: "Введите плотность продукта", productQuantity: $viewModel.density)
                .padding(.horizontal, 16)
            MainButton(text: isEdit ? "Сохранить" : "Добавить", colors: (.white, .yellow)) {
                if viewModel.errorMasege.isEmpty {
                    if isEdit {
                        viewModel.updateProduct(viewModel: mainViewModel)
                    } else {
                        viewModel.addProduct(viewModel: mainViewModel)
                    }
                    dismiss()
                } else {
                    showAlert.toggle()
                }
            }
            .padding()
            if isEdit {
                MainButton(text: "Удалить", colors: (.white, .red)) {
                    showDeleteAlert.toggle()
                }
                .padding()
            }
            Spacer()

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
         Image("AddMainProductBackgraund")
             .resizable()
             .ignoresSafeArea()
             .scaledToFill()
        )
        .onAppear {
            if isEdit {
                viewModel.getData(viewModel: mainViewModel)
            }
        }
        .alert(viewModel.errorMasege, isPresented: $showAlert) {
            Button("ОК") { }
        }
        .alert("Вы уверены, что хотите удалить единицу измерения?", isPresented: $showDeleteAlert) {
            Button("ОТМЕНА", role: .cancel) { }
            Button("УДАЛИТЬ", role: .destructive) {
                viewModel.deleteProduct(viewModel: mainViewModel)
                dismiss()
            }
        }
    }
    
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView(isEdit: false)
    }
}
