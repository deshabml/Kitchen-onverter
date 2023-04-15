//
//  MeasuringPickerView.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 14.04.2023.
//

import SwiftUI

var viewModelTest = MainViewModel()

struct MeasuringPicker: View {

    var measuringSystems: [MeasuringSystem]

    @Binding var measuringSystemPicker: MeasuringSystem

    var body: some View {
        Picker("Единици измерения", selection: $measuringSystemPicker) {
            ForEach(measuringSystems) { measuringSystem in
                Text(measuringSystem.name).tag(measuringSystem)
                    .foregroundColor(.white)
            }
        }
        .pickerStyle(.menu)
        .frame(width: CGFloat(110))
        .padding(.vertical, 10)
        .background(.white)
        .cornerRadius(18)
    }
}
