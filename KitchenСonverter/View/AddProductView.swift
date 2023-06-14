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

    var body: some View {
        VStack(spacing: 8) {
            MainText(text: isEdit ? "Изменение" : "Добавление",
                     size: 24,
                     isClassic: false)
            MainText(text: "продукта:",
                     size: 24,
                     isClassic: false)
            MainTextFild(viewModel: viewModel.productNameMainTextFildViewModel,
                         axis: .horizontal)
            MainText(text: "плотность:",
                     isClassic: false)
            MainTextFild(viewModel: viewModel.densityMainTextFildViewModel,
                         axis: .horizontal)
            HStack {
                MainButton(text: "Отмена",
                           colors: (.black, .white), completion: {
                    dismissScreen()
                })
                Spacer()
                MainButton(text: isEdit ? "Сохранить" : "Добавить",
                           colors: (.white, .yellow)) {
                    if viewModel.errorMasege.isEmpty {
                        if isEdit {
                            viewModel.updateProduct(viewModel: mainViewModel)
                        } else {
                            viewModel.addProduct(viewModel: mainViewModel)
                        }
                        dismissScreen()
                    } else {
                        showAlert.toggle()
                    }
                }
            }
            .padding(.vertical, 16)
            if isEdit {
                MainButton(text: "Удалить",
                           colors: (.white, .red)) {
                    showDeleteAlert.toggle()
                }
            }
        }
        .padding()
        .onAppear {
            if isEdit {
                viewModel.getData(viewModel: mainViewModel)
            }
        }
        .modifier(AlertElement(TextFirst: viewModel.errorMasege,
                               switchAlertFirst: $showAlert,
                               TextSecond: "Вы уверены, что хотите удалить единицу измерения?",
                               switchAlertSecond: $showDeleteAlert, complitionAlertSecond: {
            viewModel.deleteProduct(viewModel: mainViewModel)
            dismissScreen()
        }))
    }
    
}

extension AddProductView {

    func dismissScreen() {
        withAnimation {
            if isEdit {
                mainViewModel.showScreenViewModelEditProduct.isShow.toggle()
            } else {
                mainViewModel.showScreenViewModelAddProduct.isShow.toggle()
            }
        }
    }

}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView(isEdit: false)
    }
}
