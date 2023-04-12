//
//  ContentView.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//

import SwiftUI

struct MainView: View {

    @State var recordedConverters: [Converter] = []
    @State var productQuantity: String = ""
    @State var itog: String = "0,000000"
    @State var productPicker: String = ""
    @State var measuringSystemPickerFirst: String = MeasuringSystem.gram.rawValue
    @State var measuringSystemPickerSecond: String = MeasuringSystem.gram.rawValue

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
                        ForEach(MeasuringSystem.allCases) { item in
                            Text(item.rawValue)
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
                        ForEach(MeasuringSystem.allCases) { item in
                            Text(item.rawValue)
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
                    ForEach(Products.allCases) { item in
                        Text(item.rawValue)
                            .foregroundColor(.white)
                    }
                }
                .frame(height: CGFloat(220))
                .pickerStyle(.inline)
                .background(.black.opacity(0.5))
                .cornerRadius(32)
                Button {
                    calculate()
//                    guard let productQuantity = Double(productQuantity) else {
//                        return
//                    }
//                    itog = String(format: "%.6f", (productQuantity * 2))
                } label: {
                    Text("Посчитать")
                        .padding(.vertical, 16)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background(.green)
                        .cornerRadius(18)
                }
                Button {
                    savingConverter()
                } label: {
                    Text("Запомнить")
                        .padding(.vertical, 16)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .background(.yellow)
                        .cornerRadius(18)
                }
            }
                    .padding(.horizontal, 16)
            List {
                ForEach(0 ..< recordedConverters.count, id: \.self) { item in
                    ConverterCell(converter: recordedConverters[item])
                        .background(.white.opacity(0.8))
                        .listRowInsets(EdgeInsets())
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button("Удалить") {
                                print("Удалить")
                                recordedConverters.remove(at: item)
                            }
                            .tint(.red)
                        }
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

extension MainView {

    func savingConverter() {
        var measuringSystem: MeasuringSystem
        if measuringSystemPickerSecond.isEmpty {
            measuringSystem = .gram
        } else {
            switch measuringSystemPickerSecond {
                case MeasuringSystem.food.rawValue:
                    measuringSystem = .food
                case MeasuringSystem.kilogram.rawValue:
                    measuringSystem = .kilogram
                case MeasuringSystem.milliliter.rawValue:
                    measuringSystem = .milliliter
                case MeasuringSystem.liter.rawValue:
                    measuringSystem = .liter
                case MeasuringSystem.ounce.rawValue:
                    measuringSystem = .ounce
                default:
                    measuringSystem = .gram
            }
        }
        productPicker = productPicker.isEmpty ? Products.water.rawValue : productPicker
        recordedConverters.append(Converter(productName: productPicker, itog: itog, measuringSystem: measuringSystem))
    }

    func calculate() {
        guard let productQuantity = Double(productQuantity) else {
            return
        }
        let measuringSystems = (measuringSystemPickerFirst, measuringSystemPickerSecond)
        if measuringSystems.0 == measuringSystems.1 {
            itog = String(format: "%.6f", (productQuantity))
        } else if measuringSystems == (MeasuringSystem.gram.rawValue, MeasuringSystem.kilogram.rawValue) {
            itog = String(format: "%.6f", (productQuantity / 1_000))
        } else if measuringSystems == (MeasuringSystem.kilogram.rawValue, MeasuringSystem.gram.rawValue) {
            itog = String(format: "%.6f", (productQuantity * 1_000))
        } else if measuringSystems == (MeasuringSystem.liter.rawValue, MeasuringSystem.milliliter.rawValue) {
            itog = String(format: "%.6f", (productQuantity * 1_000))
        } else if measuringSystems == (MeasuringSystem.milliliter.rawValue, MeasuringSystem.liter.rawValue) {
            itog = String(format: "%.6f", (productQuantity / 1_000))
        } else if measuringSystems == (MeasuringSystem.ounce.rawValue, MeasuringSystem.food.rawValue) {
            itog = String(format: "%.6f", (productQuantity / 16))
        } else if measuringSystems == (MeasuringSystem.food.rawValue, MeasuringSystem.ounce.rawValue) {
            itog = String(format: "%.6f", (productQuantity * 16))
        } else if measuringSystems == (MeasuringSystem.kilogram.rawValue, MeasuringSystem.food.rawValue) {
            itog = String(format: "%.6f", (productQuantity * 2.2))
        } else if measuringSystems == (MeasuringSystem.gram.rawValue, MeasuringSystem.food.rawValue) {
            itog = String(format: "%.6f", (productQuantity * 2.2 / 1_000))
        } else {
            itog = String(format: "%.6f", (productQuantity * 2))
        }


    }

}
