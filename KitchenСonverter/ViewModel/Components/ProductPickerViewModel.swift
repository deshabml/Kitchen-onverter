//
//  ProductPickerViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 05.05.2023.
//

import Foundation

class ProductPickerViewModel: ObservableObject {

    var products: [Product] = []
    @Published var productPicker: Product = Product()

    func setupPicker(productPicker: Product) {
        self.productPicker = productPicker
    }

    func setupArray(products: [Product]) {
        self.products = products
    }

}
