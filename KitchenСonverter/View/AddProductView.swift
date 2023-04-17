//
//  AddProductView.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 15.04.2023.
//

import SwiftUI

struct AddProductView: View {

//    var superViewModel: MainViewModel
    @EnvironmentObject var mainViewModel: MainViewModel
    @StateObject var viewModel = AddProductViewModel()
    @State var showAlert = false
    @Environment (\.dismiss) var dismiss

    var body: some View {
        VStack {
            HStack {
                AddViewButtonCancell(completion: {
                    dismiss()
                })
                Spacer()
            }
            AddViewText(text: "Добавление", size: 30)
            AddViewText(text: "продукта:", size: 30)
            MainTextFild(placeHolder: "Введите наименование продукта", productQuantity: $viewModel.productName)
                .padding(.horizontal, 16)
            AddViewText(text: "плотность:", size: 24)
            MainTextFild(placeHolder: "Введите плотность продукта", productQuantity: $viewModel.density)
                .padding(.horizontal, 16)
            MainButton(text: "Добавить", colors: (.white, .yellow)) {
                if viewModel.errorMasege.isEmpty {
                    viewModel.addProduct(viewModel: mainViewModel)
                    dismiss()
                } else {
                    showAlert.toggle()
                }
            }
            .padding()
            Spacer()

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
         Image("AddMainProductBackgraund")
             .resizable()
             .ignoresSafeArea()
             .scaledToFill()
        )
        .alert(viewModel.errorMasege, isPresented: $showAlert) {
            Button("ОК") { }
        }
    }
    
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
