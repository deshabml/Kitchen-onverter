//
//  MainTextFild.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 13.04.2023.
//

import SwiftUI

struct MainTextFild: View {

    var placeHolder: String
    @Binding var productQuantity: String

    var body: some View {
        TextField(placeHolder, text: $productQuantity)
            .padding()
            .background(.white)
            .cornerRadius(18)
            .keyboardType(.numberPad)
    }
    
}
