//
//  AddRecipesViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 27.04.2023.
//

import SwiftUI
import PhotosUI

enum SaveRecipeError: Error {

    case emptyName
    case coincidence

}

class AddRecipesViewModel: ObservableObject {

    var recipePicker: Recipe = Recipe()
    @Published var racipeNameMainTextFildViewModel: MainTextFildViewModel = MainTextFildViewModel(placeHolder: "Введите название блюда")
    @Published var ingredientsNameMainTextFildViewModel: MainTextFildViewModel = MainTextFildViewModel(placeHolder: "Введите название")
    @Published var ingredientsAmountMainTextFildViewModel: MainTextFildViewModel = MainTextFildViewModel(placeHolder: "Количесство")
    @Published var ingredientsMSMainTextFildViewModel: MainTextFildViewModel = MainTextFildViewModel(placeHolder: "Ед. изм.")
    @Published var cookingMethodMainTextFildViewModel: MainTextFildViewModel = MainTextFildViewModel(placeHolder: "Способ приготовления")
    @Published var photoPickerRecipeViewModel: PhotoPickerRecipeViewModel = PhotoPickerRecipeViewModel()
    @Published var ingredientListViewModel: IngredientListViewModel = IngredientListViewModel()
    @Published var IsShowErrorAlert: Bool = false
    var errorMasege: String = ""

    convenience init(recipePicker: Recipe) {
        self.init()
        self.recipePicker = recipePicker
    }

    func saveIngredient() {
        guard !ingredientsNameMainTextFildViewModel.bindingProperty.isEmpty else { return }
        ingredientListViewModel.recordedIngredient.append(ProductRecipe(name: ingredientsNameMainTextFildViewModel.bindingProperty,
                                         amount: ingredientsAmountMainTextFildViewModel.bindingProperty,
                                         measuringSystem: ingredientsMSMainTextFildViewModel.bindingProperty))
    }

    func deleteIngredient(product: ProductRecipe) {
        ingredientListViewModel.recordedIngredient = ingredientListViewModel.recordedIngredient.filter({ $0 != product })
    }

    func saveRecipe(viewModel: RecipesViewModel) {
        if let Image = photoPickerRecipeViewModel.loadedImage?.data {
            viewModel.savingObject(object: Recipe(name: racipeNameMainTextFildViewModel.bindingProperty,
                                                  Image: Image,
                                                  ingredientListViewModel.recordedIngredient,
                                                  cookingMethod: cookingMethodMainTextFildViewModel.bindingProperty,
                                                  dish: viewModel.dishPickerViewModel.dishPicker.name))
        } else {
            viewModel.savingObject(object: Recipe(name: racipeNameMainTextFildViewModel.bindingProperty,
                                                  ingredientListViewModel.recordedIngredient,
                                                  cookingMethod: cookingMethodMainTextFildViewModel.bindingProperty,
                                                  dish: viewModel.dishPickerViewModel.dishPicker.name))
        }
    }

    func updateRecipe(viewModel: RecipesViewModel) {
        if let Image = photoPickerRecipeViewModel.loadedImage?.data {
            viewModel.updateObject(oldObject: recipePicker,
                                   newObject: Recipe(name: racipeNameMainTextFildViewModel.bindingProperty,
                                                     Image: Image,
                                                     ingredientListViewModel.recordedIngredient,
                                                     cookingMethod: cookingMethodMainTextFildViewModel.bindingProperty,
                                                     dish: viewModel.dishPickerViewModel.dishPicker.name))
        } else {
            viewModel.updateObject(oldObject: recipePicker,
                                   newObject: Recipe(name: racipeNameMainTextFildViewModel.bindingProperty,
                                                     ingredientListViewModel.recordedIngredient,
                                                     cookingMethod: cookingMethodMainTextFildViewModel.bindingProperty,
                                                     dish: viewModel.dishPickerViewModel.dishPicker.name))
        }
    }

    func deleteRecipe(viewModel: RecipesViewModel) {
        viewModel.recipesGridViewModel.setupRecipesPicker([])
        viewModel.deleteObject(object: recipePicker)
    }

}

extension AddRecipesViewModel {

    func ingredientsText() -> String {
        var text = "Ингридиенты:"
        ingredientListViewModel.recordedIngredient.forEach {
            text += "\n \($0.name) -- \($0.amount) \($0.measuringSystem)"
        }
        return text
    }

    func checkRecipe(recipes: [Recipe]) -> Bool {
        do {
            try throwRecipe(recipes: recipes)
        } catch SaveRecipeError.emptyName {
            IsShowErrorAlert.toggle()
            errorMasege = "Рецепт должен иметь название!"
            return false
        } catch SaveRecipeError.coincidence {
            IsShowErrorAlert.toggle()
            errorMasege = "Рецепт с таким названием уже существует!"
            return false
        } catch {
            print("Что то пошло не так.")
            return false
        }
        return true
    }

    func throwRecipe(recipes: [Recipe]) throws {
        guard !racipeNameMainTextFildViewModel.bindingProperty.isEmpty else { throw SaveRecipeError.emptyName }
        for recipe in recipes.filter({ $0 != recipePicker }) {
            guard recipe.name != racipeNameMainTextFildViewModel.bindingProperty else { throw SaveRecipeError.coincidence }
        }
        
    }

    func loadDishPicker(mainViewModel: RecipesViewModel) {
        mainViewModel.dishPickerViewModel.setupIsEdit(true)
        ingredientListViewModel.setupCompletion { productRecipe in
            self.deleteIngredient(product: productRecipe)
        }
        if mainViewModel.dishPickerViewModel.dishPicker.name == "Все" {
            guard mainViewModel.dishPickerViewModel.dishs.count > 1 else {
                mainViewModel.dishPickerViewModel.reloadDishPicker()
                return
            }
            mainViewModel.dishPickerViewModel.setupDishPicker(mainViewModel.dishPickerViewModel.dishs[1])
        } else {
            mainViewModel.dishPickerViewModel.reloadDishPicker()
        }
    }

    func dataВistribution(dishs: [Dish], mainViewModel: RecipesViewModel) {
        racipeNameMainTextFildViewModel.setupProperty(recipePicker.name)
        recipePicker.ingredients.forEach {ingredient in
            ingredientListViewModel.recordedIngredient.append(ingredient)
        }
        cookingMethodMainTextFildViewModel.setupProperty(recipePicker.cookingMethod)
        if let image = UIImage(data: recipePicker.Image) {
            photoPickerRecipeViewModel.setupImageStandard(Image(uiImage: image))
        }
        for dish in dishs {
            if dish.name == recipePicker.dish {
                mainViewModel.dishPickerViewModel.setupDishPicker(dish)
            }
        }
        photoPickerRecipeViewModel.setupLoadedImage(loadedImage: MediaFile(data: recipePicker.Image))
    }

    func checkImage() -> Bool {
        if let _ = UIImage(data: recipePicker.Image) {
            return true
        }
        return false
    }

}
