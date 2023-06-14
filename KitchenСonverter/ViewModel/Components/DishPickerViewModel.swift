//
//  DishPickerViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 05.05.2023.
//

import Foundation

class DishPickerViewModel: ObservableObject {

    @Published var isEdit: Bool = false
    @Published var dishs: [Dish] = []
    @Published var dishPicker: Dish = Dish() {
        willSet {
            if !isEdit {
                guard let completion = self.completion else { return }
                completion(newValue)
            }
        }
    }
    @Published var dishTextFild: String = ""
    var isActive = true
    var completion: ((Dish)->())?
    var completionIsEdit: ((Dish)->())?
    var completionAdd: (()->())!
    var completionUpdate: (()->(Bool))!
    var completionDelete: (()->())!

    func setupCompletions(completion: @escaping (Dish)->(), completionAdd: @escaping ()->(), completionUpdate: @escaping ()->(Bool), completionDelete: @escaping ()->()) {
        self.completion = completion
        self.completionAdd = completionAdd
        self.completionUpdate = completionUpdate
        self.completionDelete = completionDelete
    }

    func setupCompletionIsEdit(completionIsEdit: @escaping (Dish)->()) {
        self.completionIsEdit = completionIsEdit
    }

    func setupDishPicker(_ dishPicker: Dish) {
        self.dishPicker = dishPicker
    }

    func setupDishTextFild() {
        self.dishTextFild = dishPicker.name
    }

    func setupDishs(dishs: [Dish]) {
        self.dishs = dishs
        reloadDishPicker()
    }

    func reloadDishPicker() {
        dishPicker = dishPicker
    }

    func setupIsEdit(_ isEdit: Bool) {
        self.isEdit = isEdit
    }

}
