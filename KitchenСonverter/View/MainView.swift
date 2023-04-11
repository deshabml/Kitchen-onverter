//
//  ContentView.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//

import SwiftUI

struct MainView: View {

    var converterViewModel: ConverterViewModel = ConverterViewModel()
    @State var productQuantity: String = ""
    @State var itog: String = "0,000000"
    @State var productPicker: String = ""
    @State var measuringSystemPickerFirst: String = ""
    @State var measuringSystemPickerSecond: String = ""

    var body: some View {
        VStack(alignment: .center,
               spacing: 12) {
            HStack(alignment: .center,
                   spacing: 6) {
                VStack(alignment: .center,
                       spacing: 12) {
                    TextField("Количество", text: $productQuantity)
                        .padding()
                        .background(.white)
                        .cornerRadius(18)
                        .keyboardType(.numberPad)
                    Text(itog)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .foregroundColor(.white)
                        .background(.black.opacity(0.5))
                        .cornerRadius(18)
                }
                       .padding(.horizontal, 6)
                VStack(alignment: .center,
                       spacing: 12) {
                        Picker("Единици измерения", selection: $measuringSystemPickerFirst) {
                            ForEach(converterViewModel.measuringSystems) { measuringSystem in
                                Text(measuringSystem.title)
                                    .foregroundColor(.white)
                            }
                            .pickerStyle(.menu)
                            .buttonStyle(.borderless)
                    }
                    .frame(width: CGFloat(66))
                    .padding(.vertical, 10)
                    .background(.white)
                    .cornerRadius(18)
                    Picker("Единици измерения", selection: $measuringSystemPickerSecond) {
                        ForEach(converterViewModel.measuringSystems) { measuringSystem in
                            Text(measuringSystem.title)
                                .foregroundColor(.white)
                        }
                        .pickerStyle(.wheel)
                    }
                    .frame(width: CGFloat(66))
                    .padding(.vertical, 10)
                    .background(.white)
                    .cornerRadius(18)
                }
                       .padding(.horizontal, 6)
                       .foregroundColor(.blue)
            }
            VStack (alignment: .center,
                    spacing: 8) {
                Picker("Продукты", selection: $productPicker) {
                    ForEach(converterViewModel.products, id: \.description) { product in
                        Text(product)
                            .foregroundColor(.white)
                    }
                }
                .frame(height: CGFloat(220))
                .pickerStyle(.inline)
                .background(.black.opacity(0.5))
                .cornerRadius(32)
                Button("Посчитать") {
                    guard let productQuantity = Int(productQuantity) else {
                        return
                    }
                    itog = "\(productQuantity * 2)"
                }
                .padding(.vertical, 16)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .background(.green)
                .cornerRadius(18)
                Button("Запомнить") {
                    guard let _ = Int(productQuantity) else {
                        return
                    }
                    converterViewModel.addConverter(productName: productPicker, itog: itog)
                }
                .padding(.vertical, 16)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .background(.yellow)
                .cornerRadius(18)
            }
            .padding(.horizontal, 16)
            List {
                ForEach(0 ..< converterViewModel.recordedConverters.count, id: \.description) { item in
                    ConverterCell(converter: converterViewModel.recordedConverters[item])
                        .background(.green.opacity(0.8))
                        .listRowInsets(EdgeInsets())
                }.listRowBackground(Color.clear)
                Text("")
                    .listRowBackground(Color.clear)
            }.listStyle(.plain)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(18)
                .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("MainBackgraund")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
        )
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
