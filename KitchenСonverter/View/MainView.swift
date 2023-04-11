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
    @State var products: [Product] = [
        Product(title: "Вода", measuringSystem: .gram),
        Product(title: "Гречка", measuringSystem: .gram),
        Product(title: "Рис", measuringSystem: .gram),
        Product(title: "Соль", measuringSystem: .gram),
        Product(title: "Сахар", measuringSystem: .gram),
        Product(title: "Мука", measuringSystem: .gram)
    ]


    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .center,
                       spacing: 16) {
                    TextField("Количество", text: $productQuantity)
                        .padding()
                        .background(.white)
                        .cornerRadius(18)
                        .keyboardType(.numberPad)
                    Text("0,000000")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .foregroundColor(.white)
                        .background(.black.opacity(0.5))
                        .cornerRadius(18)
                }
                       .padding(6)
                VStack(alignment: .center,
                       spacing: 16) {
                    HStack {
                        Text("Г")
                        Image(systemName: "chevron.up.chevron.down")
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 20)
                    .background(.white)
                    .cornerRadius(18)
                    HStack {
                        Text("Г")
                        Image(systemName: "chevron.up.chevron.down")
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 20)
                    .background(.white)
                    .cornerRadius(18)
                }
                       .padding(6)
                       .foregroundColor(.blue)
            }
            Picker("Pararam", selection: $productPicker) {
                ForEach(products) { product in
                    Text(product.title)
                        .foregroundColor(.white)
                }
            }
            .pickerStyle(.inline)
            .background(.black.opacity(0.5))

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
