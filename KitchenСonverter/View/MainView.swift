//
//  ContentView.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//

import SwiftUI

struct MainView: View {
    @State var productQuantity: String = ""
    @State var productPicker: String = ""
    @State var measuringSystemPickerFirst: String = ""
    @State var measuringSystemPickerSecond: String = ""
    var products: [Product] = [
        Product(title: "Вода", measuringSystem: MeasuringSystem(title: "Л")),
        Product(title: "Гречка", measuringSystem: MeasuringSystem(title: "Г")),
        Product(title: "Рис", measuringSystem: MeasuringSystem(title: "Г")),
        Product(title: "Соль", measuringSystem: MeasuringSystem(title: "Г")),
        Product(title: "Сахар", measuringSystem: MeasuringSystem(title: "Г")),
        Product(title: "Мука", measuringSystem: MeasuringSystem(title: "Г"))
    ]
    var measuringSystems: [MeasuringSystem] = [
        MeasuringSystem(title: "Г"),
        MeasuringSystem(title: "Кг"),
        MeasuringSystem(title: "Л"),
        MeasuringSystem(title: "Мл"),
        MeasuringSystem(title: "У"),
        MeasuringSystem(title: "П")
    ]

    var body: some View {
        VStack(alignment: .center,
               spacing: 16) {
            HStack(alignment: .center,
                   spacing: 6) {
                VStack(alignment: .center,
                       spacing: 12) {
                    TextField("Количество", text: $productQuantity)
                        .padding()
                        .background(.white)
                        .cornerRadius(18)
                        .keyboardType(.numberPad)
                    Text("0,00000000")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .foregroundColor(.white)
                        .background(.black.opacity(0.5))
                        .cornerRadius(18)
                }
                       .padding(6)
                VStack(alignment: .center,
                       spacing: 12) {
                        Picker("Единици измерения", selection: $measuringSystemPickerFirst) {
                            ForEach(measuringSystems) { measuringSystem in
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
                        ForEach(measuringSystems) { measuringSystem in
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
            VStack {
                Picker("Продукты", selection: $productPicker) {
                    ForEach(products) { product in
                        Text(product.title)
                            .foregroundColor(.white)
                    }
                }
                .pickerStyle(.inline)
                .background(.black.opacity(0.5))
                .cornerRadius(32)
            }
            .padding()
            

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
