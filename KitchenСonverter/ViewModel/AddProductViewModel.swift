//
//  AddProductViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 15.04.2023.
//

import Foundation

enum ProductError: Error {

    case emptyName
    case emptyDensity
    case densityNotDouble

}

class AddProductViewModel: ObservableObject  {

    @Published var productName: String = ""
    @Published var density: String = ""
    var errorMasege: String {
        do {
            try checkProduct()
        } catch ProductError.emptyName {
            return "Поле название продукта пустое!"
        } catch ProductError.emptyDensity {
            return "Поле плотность продукта пустое!"
        } catch ProductError.densityNotDouble {
            return "Плотность продукта должна быть числом!"
        } catch {
            return "Что то пошло не так."
        }
        return ""
    }

    func addProduct(viewModel: MainViewModel) {
        guard let density = Double(density) else { return }
        viewModel.savingProduct(product: Product(name: productName, density: density))
    }

    func checkProduct() throws {
        guard !productName.isEmpty else { throw ProductError.emptyName }
        guard !density.isEmpty else { throw ProductError.emptyDensity }
        guard let _ = Double(density) else { throw ProductError.densityNotDouble }
    }
    
}
