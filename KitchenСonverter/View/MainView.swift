//
//  ContentView.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//

import SwiftUI

struct MainView: View {

    @StateObject var viewModel = MainViewModel()
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
                            MainAddButton(symbols: "scalemass.fill", color: .green) {
                                showAddMeasuringSystemScreen.toggle()
                            }
                            Spacer()
                        }
                        Spacer()
                        HStack {
                            MainAddButton(symbols: "takeoutbag.and.cup.and.straw.fill", color: .yellow) {
                                showAddProductScreen.toggle()
                            }
                            Spacer()
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
            ConverterList(recordedConverters: $viewModel.recordedConverters)
        }
               .frame(maxWidth: .infinity, maxHeight: .infinity)
               .background(
                Image("MainBackgraund")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
               )
               .fullScreenCover(isPresented: $showAddMeasuringSystemScreen) {
                   NavigationView { AddMeasuringSystemView(superViewModel: viewModel) }
               }
               .fullScreenCover(isPresented: $showAddProductScreen) {
                   NavigationView { AddProductView(superViewModel: viewModel) }
               }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
