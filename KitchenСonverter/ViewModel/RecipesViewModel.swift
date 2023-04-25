//
//  RecipesViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 25.04.2023.
//

import Foundation

class RecipesViewModel: ObservableObject {

    @Published var recepes: [Recipe] = []

    func getData() {
        recepes = RealmService.shared.getRecipes()
    }
}
