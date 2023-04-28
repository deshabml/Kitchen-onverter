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

    @Published var showAddDish = false
    @Published var showDeleteDish = false
    @Published var showDeleteDishAlert = false
    @Published var productName: String = ""
    @Published var density: String = ""
    @Published var product: Product?
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

    func addProduct(viewModel: CalculatorViewModel) {
        guard let density = Double(density) else { return }
        viewModel.savingObject(object: Product(name: productName, density: density))
    }

    func checkProduct() throws {
        guard !productName.isEmpty else { throw ProductError.emptyName }
        guard !density.isEmpty else { throw ProductError.emptyDensity }
        guard let _ = Double(density) else { throw ProductError.densityNotDouble }
    }
    
}

extension AddProductViewModel {

    func getData(viewModel: CalculatorViewModel) {
        product = viewModel.productPicker
        guard let product = product else { return }
        productName = product.name
        density = "\(product.density)"
    }

    func updateProduct(viewModel: CalculatorViewModel) {
        guard let density = Double(density) else { return }
        guard let product = product else { return }
        viewModel.updateObject(oldObject: product, newObject: Product(name: productName, density: density))
    }

    func deleteProduct(viewModel: CalculatorViewModel) {
        guard let product = product else { return }
        viewModel.deleteObject(object: product)
        viewModel.productPicker = RealmService.shared.getProduct()[0]
    }

}
