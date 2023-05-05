//
//  MeasuringPickerView.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 14.04.2023.
//

import SwiftUI

struct MeasuringPicker: View {

    @StateObject var viewModel: MeasuringPickerViewModel

    var body: some View {
        Picker("Единици измерения", selection: $viewModel.measuringSystemPicker) {
            ForEach(viewModel.measuringSystems) { measuringSystem in
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
