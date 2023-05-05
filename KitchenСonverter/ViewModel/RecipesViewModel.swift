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
    @Published var recipesGridViewModel: RecipesGridViewModel = RecipesGridViewModel()
    @Published var dishPickerViewModel: DishPickerViewModel = DishPickerViewModel()
    @Published var showDeleteDishAlert = false
    @Published var showCoincidenceAlert: Bool = false
    @Published var dishTextAlert: String = ""
    var isFirstView: Bool = true
    private var lastDishPicker: Dish = Dish()

    func savingDish() {
        guard !dishPickerViewModel.dishTextFild.isEmpty else { return }
        do {
            try checkAddDish()
        } catch EditDishError.coincidence {
            dishTextAlert = "Группа с таким названием уже есть!"
            showCoincidenceAlert.toggle()
            return
        } catch {
            print("Что то пошло не так.")
            return
        }
        savingObject(object: Dish(name: dishPickerViewModel.dishTextFild))
    }

    func updateDish() -> Bool {
        guard !dishPickerViewModel.dishTextFild.isEmpty else { return false }
        let updDish = dishPickerViewModel.dishPicker
        do {
            try checkEditDish()
        } catch EditDishError.notEmpty {
            dishPickerViewModel.setupDishPicker(RealmService.shared.getDishs()[0])
            for index in 0..<recipes.count {
                if recipes[index].dish == updDish.name {
                    updateObject(oldObject: recipes[index],
                                 newObject: Recipe(name: recipes[index].name,
                                                   ingredientsList: recipes[index].ingredients,
                                                   cookingMethod: recipes[index].cookingMethod,
                                                   dish: dishPickerViewModel.dishTextFild))
                }
            }
            updateObject(oldObject: updDish, newObject: Dish(name: dishPickerViewModel.dishTextFild))
            return true
        } catch EditDishError.coincidence {
            dishTextAlert = "Группа с таким названием уже есть!"
            showCoincidenceAlert.toggle()
            return false
        } catch {
            print("Что то пошло не так.")
            return false
        }
        dishPickerViewModel.setupDishPicker(RealmService.shared.getDishs()[0])
        updateObject(oldObject: updDish, newObject: Dish(name: dishPickerViewModel.dishTextFild))
        return true
    }

    func checkAddDish() throws {
        for dish in dishPickerViewModel.dishs {
            guard dish.name != dishPickerViewModel.dishTextFild else { throw EditDishError.coincidence }
        }
    }

    func checkEditDish() throws {
        for dish in dishPickerViewModel.dishs.filter({ $0 != dishPickerViewModel.dishPicker }) {
            guard dish.name != dishPickerViewModel.dishTextFild else { throw EditDishError.coincidence }
        }
        guard recipes.filter({ $0.dish == dishPickerViewModel.dishPicker.name }).isEmpty else { throw EditDishError.notEmpty }
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
        let delDish = dishPickerViewModel.dishPicker
        dishPickerViewModel.setupDishPicker(RealmService.shared.getDishs()[0])
        deleteObject(object: delDish)
        return true
    }

}

extension RecipesViewModel {

    func loadingScreen() {
        if isFirstView {
            dishPickerViewModel.setupCompletions { newValue in
                self.dishPickerAction(newValue)
            } completionAdd: {
                self.savingDish()
            } completionUpdate: {
                self.updateDish()
            } completionDelete: {
                self.showDeleteDishAlert.toggle()
            }
            getStartPickerData(index: 0)
            getData()
            isFirstView.toggle()
        }
        dishPickerViewModel.setupIsEdit(false)
        dishPickerViewModel.setupDishPicker(lastDishPicker)
    }

    func getData() {
        recipes = RealmService.shared.getRecipes()
        dishPickerViewModel.setupDishs(dishs: RealmService.shared.getDishs())
    }

    func getStartPickerData(index: Int) {
        dishPickerViewModel.setupDishPicker(RealmService.shared.getDishs()[index])
    }

    func dishPickerAction(_ newValue: Dish) {
        lastDishPicker = newValue
        recipesGridViewModel.setupNameDishPicker(newValue.name)
        recipesGridViewModel.setupRecipesPicker([])
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            if newValue.name == "Все" {
                self.recipesGridViewModel.setupRecipesPicker(self.recipes)
            } else {
                self.recipesGridViewModel.setupRecipesPicker(self.recipes.filter { $0.dish == newValue.name })
            }
        }
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
