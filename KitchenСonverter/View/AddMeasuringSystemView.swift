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
                MainButton(text: "Отмена", colors: (.black, .white), completion: {
                    dismiss()
                }, isCancelStyle: true)
                Spacer()
            }
            MainText(text: isEdit ? "Изменение" : "Добавление",
                     size: 30,
                     isClassic: false)
            MainText(text: "единицы измерения:",
                     size: 30,
                     isClassic: false)
            MainTextFild(viewModel: viewModel.nameMSMainTextFildViewModel,
                         axis: .horizontal)
                .padding(.horizontal, 16)
            HStack {
                MainText(text: "Тип:",
                         isClassic: false)
                AddMeasuringSystemPicker(viewModel: viewModel.addMeasuringSystemPickerViewModel)
                Spacer()
            }
            .padding(.horizontal, 16)
            MainText(text: viewModel.textEnterЕheRatio,
                     isClassic: false)
            MainText(text: "поместиться в 1?",
                     isClassic: false)
            MainTextFild(viewModel: viewModel.ratioMSMainTextFildViewModel,
                         axis: .horizontal)
                .padding(.horizontal, 16)
            VStack(spacing: 16) {
                MainButton(text: isEdit ? "Сохранить" : "Добавить",
                           colors: (.green, .white)) {
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
                    MainButton(text: "Удалить",
                               colors: (.white, .red)) {
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
        .modifier(AlertElement(TextFirst: viewModel.errorMasege,
                               switchAlertFirst: $showAlert,
                               TextSecond: "Вы уверены, что хотите удалить единицу измерения?",
                               switchAlertSecond: $showDeleteAlert, complitionAlertSecond: {
            viewModel.deleteMeasuringSystem(viewModel: mainViewModel)
            dismiss()
        }))
    }

}

struct AddMeasuringSystemView_Previews: PreviewProvider {
    static var previews: some View {
        AddMeasuringSystemView(isEdit: false)
    }
}
