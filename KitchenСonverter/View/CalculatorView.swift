//
//  ContentView.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//

import SwiftUI

struct CalculatorView: View {

    @StateObject var viewModel = CalculatorViewModel()
    @State var showAddMeasuringSystemScreen = false
    @State var showAddProductScreen = false

    var body: some View {
        VStack(alignment: .center,
               spacing: 12) {
            HStack(alignment: .center,
                   spacing: 6) {
                VStack(alignment: .center,
                       spacing: 12) {
                    MainTextFild(placeHolder: "Количество", productQuantity: $viewModel.productQuantity)
                    MainText(text: viewModel.itog)
                }
                       .padding(.horizontal, 6)
                VStack(alignment: .center,
                       spacing: 12) {
                    MeasuringPicker(measuringSystems: viewModel.measuringSystems, measuringSystemPicker: $viewModel.measuringSystemPickerFirst)
                    MeasuringPicker(measuringSystems: viewModel.measuringSystems, measuringSystemPicker: $viewModel.measuringSystemPickerSecond)
                }
                       .padding(.horizontal, 6)
                       .foregroundColor(.blue)
            }
            VStack(alignment: .center,
                    spacing: 8) {
                ZStack {
                    ProductPicker(products: viewModel.products, productPicker: $viewModel.productPicker)
                    VStack {
                        HStack {
                            MainAddButton(symbols: "scalemass.fill", color: .green, isEdit: false) {
                                viewModel.isEditScreen = false
                                showAddMeasuringSystemScreen.toggle()
                            }
                            Spacer()
                            MainAddButton(symbols: "square.and.pencil", color: .green, isEdit: true) {
                                viewModel.isEditScreen = true
                                showAddMeasuringSystemScreen.toggle()
                            }
                        }
                        Spacer()
                        HStack {
                            MainAddButton(symbols: "takeoutbag.and.cup.and.straw.fill", color: .yellow, isEdit: false) {
                                viewModel.isEditScreen = false
                                showAddProductScreen.toggle()
                            }
                            Spacer()
                            MainAddButton(symbols: "square.and.pencil", color: .yellow, isEdit: true) {
                                viewModel.isEditScreen = true
                                showAddProductScreen.toggle()
                            }
                        }
                    }
                }
                MainButton(text: "Посчитать", colors: (.white, .green)) {
                    viewModel.recalculation()
                }
                MainButton(text: "Запомнить", colors: (.black, .yellow)) {
                    viewModel.savingConverter()
                }
            }
                    .padding(.horizontal, 16)
            ConverterList(recordedConverters: $viewModel.recordedConverters) { converter in
                viewModel.deleteObject(object: converter)
            }
        }
               .frame(maxWidth: .infinity, maxHeight: .infinity)
               .background(
                Image("CalculatorBackgraund")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
               )
               .onAppear {
                   viewModel.initialFillingDataBase()
                   viewModel.getStartPickerData()
                   viewModel.getAllData()
               }
               .fullScreenCover(isPresented: $showAddMeasuringSystemScreen) {
                   NavigationView { AddMeasuringSystemView(isEdit: viewModel.isEditScreen)
                           .environmentObject(viewModel)
                   }
               }
               .fullScreenCover(isPresented: $showAddProductScreen) {
                   NavigationView { AddProductView(isEdit: viewModel.isEditScreen)
                           .environmentObject(viewModel)
                   }
               }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
