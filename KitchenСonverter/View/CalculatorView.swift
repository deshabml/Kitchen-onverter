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
                            NavigationLink {
                                AddMeasuringSystemView(isEdit: false)
                                    .environmentObject(viewModel)
                            } label: {
                                MainAddLabel(isEdit: false, symbols: "scalemass.fill", color: .yellow)
                            }
                            Spacer()
                            NavigationLink {
                                AddMeasuringSystemView(isEdit: true)
                                    .environmentObject(viewModel)
                            } label: {
                                MainAddLabel(isEdit: true, symbols: "square.and.pencil", color: .yellow)
                            }
                        }
                        Spacer()
                        HStack {
                            NavigationLink {
                                AddProductView(isEdit: false)
                                    .environmentObject(viewModel)
                            } label: {
                                MainAddLabel(isEdit: false, symbols: "takeoutbag.and.cup.and.straw.fill", color: .green)
                            }
                            Spacer()
                            NavigationLink {
                                AddProductView(isEdit: true)
                                    .environmentObject(viewModel)
                            } label: {
                                MainAddLabel(isEdit: true, symbols: "square.and.pencil", color: .green)
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
        .modifier(BackgroundElement(ImageName: "CalculatorBackgraund", onApperComplition: { viewModel.loadingScreen() }))
        .animation(.easeInOut(duration: 0.3), value: viewModel.recordedConverters)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CalculatorView()
        }
    }
}
