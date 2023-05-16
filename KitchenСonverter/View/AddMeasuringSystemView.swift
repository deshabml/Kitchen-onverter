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

    var body: some View {
        VStack {
            VStack {
                MainText(text: isEdit ? "Изменение" : "Добавление",
                         size: 24,
                         isClassic: false)
                MainText(text: "единицы измерения:",
                         size: 24,
                         isClassic: false)
                MainTextFild(viewModel: viewModel.nameMSMainTextFildViewModel,
                             axis: .horizontal)
            }
                .padding()
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
            VStack(spacing: 8) {
                HStack {
                    MainButton(text: "Отмена", colors: (.black, .white), completion: {
                        dismissScreen()
                    })
                    MainButton(text: isEdit ? "Сохранить" : "Добавить",
                               colors: (.green, .white)) {
                        if viewModel.errorMasege.isEmpty {
                            if isEdit {
                                viewModel.updateMeasuringSystem(viewModel: mainViewModel)
                            } else {
                                viewModel.addMeasuringSystem(viewModel: mainViewModel)
                            }
                            dismissScreen()
                        } else {
                            showAlert.toggle()
                        }
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
        }
        .onAppear {
            if isEdit {
                viewModel.getData(viewModel: mainViewModel)
            }
        }
        .modifier(AlertElement(TextFirst: viewModel.errorMasege,
                               switchAlertFirst: $showAlert,
                               TextSecond: "Вы уверены, что хотите удалить единицу измерения?",
                               switchAlertSecond: $showDeleteAlert, complitionAlertSecond: {
            viewModel.deleteMeasuringSystem(viewModel: mainViewModel)
            dismissScreen()
        }))
    }

}

extension AddMeasuringSystemView {

    func dismissScreen() {
        withAnimation {
            if isEdit {
                mainViewModel.showScreenViewModelEditMS.isShow.toggle()
            } else {
                mainViewModel.showScreenViewModelAddMS.isShow.toggle()
            }
        }
    }

}

struct AddMeasuringSystemView_Previews: PreviewProvider {
    static var previews: some View {
        AddMeasuringSystemView(isEdit: false)
    }
}
