//
//  RecipesViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 25.04.2023.
//

import Foundation

enum EditDishError: Error {

    case coincidence
    case notEmpty

}

class RecipesViewModel: ObservableObject {

    @Published var recipes: [Recipe] = []
    @Published var recipesPicker: [Recipe] = []
    @Published var dishs: [Dish] = []
    @Published var dishPicker: Dish = Dish() {
        willSet {
            if newValue.name == "Все" {
                recipesPicker = recipes
            } else {
                recipesPicker = recipes.filter { $0.dish == newValue.name }
            }
        }
    }
    @Published var dishTextFild: String = ""
    @Published var showCoincidenceAlert: Bool = false
    @Published var dishTextAlert: String = ""

    func savingDish() {
        guard !dishTextFild.isEmpty else { return }
        savingObject(object: Dish(name: dishTextFild))
    }

    func updateDish() -> Bool {
        guard !dishTextFild.isEmpty else { return false }
        let updDish = dishPicker
        do {
            try checkEditDish()
        } catch EditDishError.notEmpty {
            dishPicker = RealmService.shared.getDishs()[0]
            for index in 0..<recipes.count {
                if recipes[index].dish == updDish.name {
                    updateObject(oldObject: recipes[index],
                                 newObject: Recipe(name: recipes[index].name,
                                                   ingredientsList: recipes[index].ingredients,
                                                   cookingMethod: recipes[index].cookingMethod,
                                                   dish: dishTextFild))
                }
            }
            updateObject(oldObject: updDish, newObject: Dish(name: dishTextFild))
            return true
        } catch EditDishError.coincidence {
            dishTextAlert = "Группа с таким названием уже есть!"
            showCoincidenceAlert.toggle()
            return false
        } catch {
            print("Что то пошло не так.")
            return false
        }
        dishPicker = RealmService.shared.getDishs()[0]
        updateObject(oldObject: updDish, newObject: Dish(name: dishTextFild))
        return true
    }

    func checkEditDish() throws {
        for dish in dishs.filter({ $0 != dishPicker }) {
            guard dish.name != dishTextFild else { throw EditDishError.coincidence }
        }
        guard recipes.filter({ $0.dish == dishPicker.name }).isEmpty else { throw EditDishError.notEmpty }
    }

    func deleteDish() -> Bool {
        do {
            try checkEditDish()
        } catch EditDishError.notEmpty {
            dishTextAlert = "Нельзя удалить группу, в которой есть рецепты!"
            showCoincidenceAlert.toggle()
            return false
        } catch EditDishError.coincidence {
        } catch {
            print("Что то пошло не так.")
            return false
        }
        let delDish  = dishPicker
        dishPicker = RealmService.shared.getDishs()[0]
        deleteObject(object: delDish)
        return true
    }

}

extension RecipesViewModel {

    func loadingScreen() {
        getStartPickerData(index: 0)
        getData()
    }

    func getData() {
        recipes = RealmService.shared.getRecipes()
        dishs = RealmService.shared.getDishs()
        dishPicker = dishPicker
    }

    func getStartPickerData(index: Int) {
        dishPicker = RealmService.shared.getDishs()[index]
    }

    func savingObject<T>(object: T) {
        RealmService.shared.createObject(object: object)
        getData()
    }

    func updateObject<T>(oldObject: T, newObject: T) {
        RealmService.shared.updateObject(oldObject: oldObject, newObject: newObject)
        getData()
    }

    func deleteObject<T>(object: T) {
        RealmService.shared.deleteObject(object: object)
        getData()
    }

}
