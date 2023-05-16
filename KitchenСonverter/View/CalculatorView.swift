//
//  ContentView.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//

import SwiftUI

struct CalculatorView: View {

    @StateObject var viewModel = CalculatorViewModel()

    var body: some View {
        VStack(alignment: .center,
               spacing: 12) {
            ZStack {
                VStack {
                    HStack(alignment: .center,
                           spacing: 6) {
                        VStack(alignment: .center,
                               spacing: 12) {
                            MainTextFild(viewModel: viewModel.productMainTextFildViewModel, axis: .horizontal)
                            MainText(text: viewModel.itog)
                        }
                               .padding(.horizontal, 6)
                        VStack(alignment: .center,
                               spacing: 12) {
                            MeasuringPicker(viewModel: viewModel.firstMeasuringPickerViewModel)
                            MeasuringPicker(viewModel: viewModel.secondMeasuringPickerViewModel)
                        }
                               .padding(.horizontal, 6)
                               .foregroundColor(.blue)
                    }
                    VStack(alignment: .center,
                           spacing: 8) {
                        ZStack {
                            ProductPicker(viewModel: viewModel.productPickerViewModel)
                            VStack {
                                HStack {
                                    MainAddEditButton(isEdit: false,
                                                      symbols: "scalemass.fill",
                                                      color: .yellow) {
                                        viewModel.showScreenViewModelAddMS.isShow.toggle()
                                    }
                                    Spacer()
                                    MainAddEditButton(isEdit: true,
                                                      symbols: "square.and.pencil",
                                                      color: .yellow) {
                                        viewModel.showScreenViewModelEditMS.isShow.toggle()
                                    }
                                }
                                Spacer()
                                HStack {
                                    MainAddEditButton(isEdit: false,
                                                      symbols: "takeoutbag.and.cup.and.straw.fill",
                                                      color: .green) {
                                        viewModel.showScreenViewModelAddProduct.isShow.toggle()
                                    }
                                    Spacer()
                                    MainAddEditButton(isEdit: true,
                                                      symbols: "square.and.pencil",
                                                      color: .green) {
                                        viewModel.showScreenViewModelEditProduct.isShow.toggle()
                                    }
                                }
                            }
                        }
                        MainButton(text: "Посчитать",
                                   colors: (.white, .green)) {
                            viewModel.recalculation()
                        }
                        MainButton(text: "Запомнить",
                                   colors: (.black, .yellow)) {
                            viewModel.savingConverter()
                        }
                    }
                           .padding(.horizontal, 16)
                    ConverterList(viewModel: viewModel.recordedConvertersConverterListViewModel)
                }
                ShowScreen(viewModel: viewModel.showScreenViewModelAddMS,
                           screen: AddMeasuringSystemView(isEdit: false))
                .environmentObject(viewModel)
                ShowScreen(viewModel: viewModel.showScreenViewModelEditMS,
                           screen: AddMeasuringSystemView(isEdit: true))
                .environmentObject(viewModel)
                ShowScreen(viewModel: viewModel.showScreenViewModelAddProduct,
                           screen: AddProductView(isEdit: false))
                .environmentObject(viewModel)
                ShowScreen(viewModel: viewModel.showScreenViewModelEditProduct,
                           screen: AddProductView(isEdit: true))
                .environmentObject(viewModel)
            }
        }
               .modifier(BackgroundElement(ImageName: "CalculatorBackgraund",
                                           onApperComplition: { viewModel.loadingScreen() }))
               .animation(.easeInOut(duration: 0.3),
                          value: viewModel.recordedConvertersConverterListViewModel.recordedConverters)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CalculatorView()
        }
    }
}
