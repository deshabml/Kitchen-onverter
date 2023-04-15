//
//  AddMeasuringSystemView.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 15.04.2023.
//

import SwiftUI

struct AddMeasuringSystemView: View {

    var superViewModel: MainViewModel
    @StateObject var viewModel = AddMeasuringSystemViewModel()
    @State var showAlert = false

    @Environment(\.presentationMode) var presentation

    var body: some View {
        VStack {
            HStack {
                AddViewButtonCancell(completion: {
                    presentation.wrappedValue.dismiss()
                })
                Spacer()
            }
            AddViewText(text: "Добавление", size: 30)
            AddViewText(text: "единицы измерения:", size: 30)
            MainTextFild(placeHolder: "Введите наименование", productQuantity: $viewModel.measuringSystemsName)
                .padding(.horizontal, 16)
            HStack {
                AddViewText(text: "Тип:", size: 24)
                AddMeasuringSystemPicker(typeMeasuringSystem: viewModel.typeMeasuringSystem, typeMeasuringSystemPicker: $viewModel.typeMeasuringSystemPicker)
                Spacer()
            }
            .padding(.horizontal, 16)
            AddViewText(text: viewModel.textEnterЕheRatio, size: 24)
            AddViewText(text: "поместиться в 1?", size: 24)
            MainTextFild(placeHolder: "Введите соотношение", productQuantity: $viewModel.measuringSystemsRatio)
                .padding(.horizontal, 16)
                MainButton(text: "Добавить", colors: (.green, .white)) {
                    if viewModel.errorMasege.isEmpty {
                        viewModel.addMeasuringSystem(viewModel: superViewModel)
                        presentation.wrappedValue.dismiss()
                    } else {
                        showAlert.toggle()
                    }
                }
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
         Image("AddMeasuringSystemBackgraund")
             .resizable()
             .ignoresSafeArea()
             .scaledToFill()
        )
        .alert(viewModel.errorMasege, isPresented: $showAlert) {
            Button("ОК") { }
        }
    }

}

struct AddMeasuringSystemView_Previews: PreviewProvider {
    static var previews: some View {
        AddMeasuringSystemView(superViewModel: MainViewModel())
    }
}
