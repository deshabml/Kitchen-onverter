//
//  MainTextFildViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 04.05.2023.
//

import Foundation

class MainTextFildViewModel: ObservableObject {

    @Published var bindingProperty: String = ""
    var placeHolder: String

    init(placeHolder: String) {
        self.placeHolder = placeHolder
    }

    func setupProperty(_ bindingProperty: String) {
        self.bindingProperty = bindingProperty
    }

    func clear() {
        bindingProperty = ""
    }

}
