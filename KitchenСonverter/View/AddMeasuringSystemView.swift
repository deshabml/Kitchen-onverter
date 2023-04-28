//
//  AddMeasuringSystemView.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 15.04.2023.
//

import SwiftUI

struct AddMeasuringSystemView: View {

    @EnvironmentObject var mainViewModel: CalculatorViewModel
    @StateObject var viewModel = AddMeasuringSystemViewModel()
    @State var showAlert = false
    @State var showDeleteAlert = false
    let isEdit: Bool
    @Environment (\.dismiss) var dismiss

    var body: some View {
        VStack {
            HStack {
                AddViewButton(text: "Отмена", colors: (.black, .white), completion: {
                    dismiss()
                })
                Spacer()
            }
            AddViewText(text: isEdit ? "Изменение" : "Добавление", size: 30)
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
            VStack(spacing: 16) {
                MainButton(text: isEdit ? "Сохранить" : "Добавить", colors: (.green, .white)) {
                    if viewModel.errorMasege.isEmpty {
                        if isEdit {
                            viewModel.updateMeasuringSystem(viewModel: mainViewModel)
                        } else {
                            viewModel.addMeasuringSystem(viewModel: mainViewModel)
                        }
                        dismiss()
                    } else {
                        showAlert.toggle()
                    }
                }
                if isEdit {
                    MainButton(text: "Удалить", colors: (.white, .red)) {
                        showDeleteAlert.toggle()
                    }
                }
            }
            .padding()
            Spacer()
        }
        .modifier(BackgroundElement(ImageName: "AddMeasuringSystemBackgraund", onApperComplition: {
            if isEdit {
                viewModel.getData(viewModel: mainViewModel)
            }
        }))
        .alert(viewModel.errorMasege, isPresented: $showAlert) {
            Button("ОК") { }
        }
        .alert("Вы уверены, что хотите удалить единицу измерения?", isPresented: $showDeleteAlert) {
            Button("ОТМЕНА", role: .cancel) { }
            Button("УДАЛИТЬ", role: .destructive) {
                viewModel.deleteMeasuringSystem(viewModel: mainViewModel)
                dismiss()
            }
        }
    }

}

struct AddMeasuringSystemView_Previews: PreviewProvider {
    static var previews: some View {
        AddMeasuringSystemView(isEdit: false)
    }
}
