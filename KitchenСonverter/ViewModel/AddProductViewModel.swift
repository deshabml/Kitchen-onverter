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
    @Published var productNameMainTextFildViewModel: MainTextFildViewModel = MainTextFildViewModel(placeHolder: "Введите наименование продукта")
    @Published var densityMainTextFildViewModel: MainTextFildViewModel = MainTextFildViewModel(placeHolder: "Введите плотность продукта")
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
        guard let density = Double(densityMainTextFildViewModel.bindingProperty) else { return }
        viewModel.savingObject(object: Product(name: productNameMainTextFildViewModel.bindingProperty, density: density))
    }

    func checkProduct() throws {
        guard !productNameMainTextFildViewModel.bindingProperty.isEmpty else { throw ProductError.emptyName }
        guard !densityMainTextFildViewModel.bindingProperty.isEmpty else { throw ProductError.emptyDensity }
        guard let _ = Double(densityMainTextFildViewModel.bindingProperty) else { throw ProductError.densityNotDouble }
    }
    
}

extension AddProductViewModel {

    func getData(viewModel: CalculatorViewModel) {
        product = viewModel.productPickerViewModel.productPicker
        guard let product = product else { return }
        productNameMainTextFildViewModel.setupProperty(product.name)
        densityMainTextFildViewModel.setupProperty("\(product.density)")
    }

    func updateProduct(viewModel: CalculatorViewModel) {
        guard let density = Double(densityMainTextFildViewModel.bindingProperty) else { return }
        guard let product = product else { return }
        viewModel.updateObject(oldObject: product,
                               newObject: Product(name: productNameMainTextFildViewModel.bindingProperty,
                                                  density: density))
    }

    func deleteProduct(viewModel: CalculatorViewModel) {
        guard let product = product else { return }
        viewModel.deleteObject(object: product)
        viewModel.productPickerViewModel.setupPicker(productPicker: RealmService.shared.getProduct()[0])
    }

}
