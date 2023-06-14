//
//  AddMeasuringSystemPickerViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 05.05.2023.
//

import Foundation

class AddMeasuringSystemPickerViewModel: ObservableObject {

    var typeMeasuringSystem: [TypeMeasuringSystem] = [TypeMeasuringSystem(name: "Вес", isWeight: true),
                                                      TypeMeasuringSystem(name: "Объём", isWeight: false)]
    @Published var typeMeasuringSystemPicker: TypeMeasuringSystem = TypeMeasuringSystem(name: "Вес", isWeight: true)

    func setupPicker(typeMeasuringSystemPicker: TypeMeasuringSystem) {
        self.typeMeasuringSystemPicker = typeMeasuringSystemPicker
    }

    func setupArray(typeMeasuringSystem: [TypeMeasuringSystem]) {
        self.typeMeasuringSystem = typeMeasuringSystem
    }
    
}
