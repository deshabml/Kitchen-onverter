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
                MainButton(text: "Отмена",
                           colors: (.black, .white), completion: {
                    dismiss()
                }, isCancelStyle: true)
                Spacer()
            }
            MainText(text: isEdit ? "Изменение" : "Добавление",
                     size: 30,
                     isClassic: false)
            MainText(text: "продукта:",
                     size: 30,
                     isClassic: false)
            MainTextFild(viewModel: viewModel.productNameMainTextFildViewModel,
                         axis: .horizontal)
                .padding(.horizontal, 16)
            MainText(text: "плотность:",
                     isClassic: false)
            MainTextFild(viewModel: viewModel.densityMainTextFildViewModel,
                         axis: .horizontal)
                .padding(.horizontal, 16)
            MainButton(text: isEdit ? "Сохранить" : "Добавить",
                       colors: (.white, .yellow)) {
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
                MainButton(text: "Удалить",
                           colors: (.white, .red)) {
                    showDeleteAlert.toggle()
                }
                .padding()
            }
            Spacer()

        }
        .modifier(BackgroundElement(ImageName: "AddMainProductBackgraund", onApperComplition: {
            if isEdit {
                viewModel.getData(viewModel: mainViewModel)
            }
        }))
        .modifier(AlertElement(TextFirst: viewModel.errorMasege,
                               switchAlertFirst: $showAlert,
                               TextSecond: "Вы уверены, что хотите удалить единицу измерения?",
                               switchAlertSecond: $showDeleteAlert, complitionAlertSecond: {
            viewModel.deleteProduct(viewModel: mainViewModel)
            dismiss()
        }))
    }
    
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView(isEdit: false)
    }
}
