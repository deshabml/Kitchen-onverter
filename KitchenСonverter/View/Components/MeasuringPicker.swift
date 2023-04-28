//
//  MeasuringPickerView.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 14.04.2023.
//

import SwiftUI

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
        .modifier(SettingsElement(verticalPadding: 10,
                                  horizontalPadding: 0,
                                  backgroundColor: .white))
    }
    
}
