//
//  MeasuringPickerViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 04.05.2023.


import Foundation

class MeasuringPickerViewModel: ObservableObject {

    var measuringSystems: [MeasuringSystem] = []
    @Published var measuringSystemPicker: MeasuringSystem = MeasuringSystem()

    func setupPicker(measuringSystemPicker: MeasuringSystem) {
        self.measuringSystemPicker = measuringSystemPicker
    }

    func setupArray(measuringSystems: [MeasuringSystem]) {
        self.measuringSystems = measuringSystems
    }

}
