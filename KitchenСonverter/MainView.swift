//
//  ContentView.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//

import SwiftUI

struct MainView: View {
    @State var productQuantity: String = ""

    var body: some View {
        VStack {
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
