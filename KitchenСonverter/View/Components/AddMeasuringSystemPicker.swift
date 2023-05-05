//
//  AddMeasuringSystemPicker.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 15.04.2023.
//

import SwiftUI

struct AddMeasuringSystemPicker: View {

    @StateObject var viewModel: AddMeasuringSystemPickerViewModel
    
    var body: some View {
        Picker("Тип Е. И.", selection: $viewModel.typeMeasuringSystemPicker) {
            ForEach(viewModel.typeMeasuringSystem) { type in
                Text(type.name).tag(type)
                    .foregroundColor(.white)
            }
        }
        .frame(height: CGFloat(100))
        .frame(width: CGFloat(200))
        .pickerStyle(.inline)
        .background(.black.opacity(0.5))
        .cornerRadius(32)
    }
    
}
