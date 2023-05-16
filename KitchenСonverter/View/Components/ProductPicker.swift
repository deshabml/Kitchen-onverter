//
//  ProductPicker.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 14.04.2023.
//

import SwiftUI

struct ProductPicker: View {

    @StateObject var viewModel: ProductPickerViewModel

    var body: some View {
        Picker("Продукты", selection: $viewModel.productPicker) {
            ForEach(viewModel.products) { product in
                Text(product.name).tag(product)
                    .foregroundColor(.white)
            }
        }
        .frame(height: CGFloat(220))
        .pickerStyle(.inline)
        .background(.black.opacity(0.5))
        .cornerRadius(32)
    }
    
}
