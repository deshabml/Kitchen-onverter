//
//  ConverterListViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 04.05.2023.
//

import Foundation

class ConverterListViewModel: ObservableObject {

    @Published var recordedConverters: [Converter] = []
    var completion: ((Converter)->())!

    func setupRecordedConverters(_ recordedConverters: [Converter]) {
        self.recordedConverters = recordedConverters
    }

    func setupCompletion(completion: @escaping (Converter)->()) {
        self.completion = completion
    }

}
