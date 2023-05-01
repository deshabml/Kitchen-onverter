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

}

class AddRecipesViewModel: ObservableObject {

    @Published var racipeName: String = ""
    @Published var ingredientsName: String = ""
    @Published var ingredientsAmount: String = ""
    @Published var ingredientsMeasuringSystem: String = ""
    @Published var cookingMethod: String = ""
    @Published var selectedPhoto: PhotosPickerItem? {
        didSet {
            if let selectedPhoto {
                self.convertPhoto(photo: selectedPhoto)
            }
        }
    }
    @Published var loadedImage: MediaFile?
    @Published var ingredients: [ProductRecipe] = []
    @Published var imageStandard: Image = Image("RecipeIcons")
    @Published var dishPicker: Dish = Dish()
    @Published var IsShowErrorAlert: Bool = false
    var errorMasege: String = ""

    func saveIngredient() {
        ingredients.append(ProductRecipe(name: ingredientsName, amount: ingredientsAmount, measuringSystem: ingredientsMeasuringSystem))
    }

    func deleteIngredient(product: ProductRecipe) {
        ingredients = ingredients.filter { $0 != product }
    }

    func saveRecipe(viewModel: RecipesViewModel) {
        if let Image = loadedImage?.data {
            viewModel.savingObject(object: Recipe(name: racipeName,
                                                  Image: Image,
                                                  ingredients,
                                                  cookingMethod: cookingMethod,
                                                  dish: dishPicker.name))
        } else {
            viewModel.savingObject(object: Recipe(name: racipeName,
                                                  ingredients,
                                                  cookingMethod: cookingMethod,
                                                  dish: dishPicker.name))
        }
    }

    func updateRecipe(recipePickerOld: Recipe, viewModel: RecipesViewModel) {
        if let Image = loadedImage?.data {
            viewModel.updateObject(oldObject: recipePickerOld,
                                   newObject: Recipe(name: racipeName,
                                                     Image: Image,
                                                     ingredients,
                                                     cookingMethod: cookingMethod,
                                                     dish: dishPicker.name))
        } else {
            viewModel.updateObject(oldObject: recipePickerOld,
                                   newObject: Recipe(name: racipeName,
                                                     ingredients,
                                                     cookingMethod: cookingMethod,
                                                     dish: dishPicker.name))
        }
    }

    func deleteRecipe(recipe: Recipe, viewModel: RecipesViewModel) {
        viewModel.deleteObject(object: recipe)
    }

}

extension AddRecipesViewModel {

    func ingredientsText() -> String {
        var text = "Ингридиенты:"
        ingredients.forEach {
            text += "\n \($0.name) -- \($0.amount) \($0.measuringSystem)"
        }
        return text
    }

    func checkRecipe() -> Bool {
        do {
            try throwRecipe()
        } catch SaveRecipeError.emptyName {
            IsShowErrorAlert.toggle()
            errorMasege = "Рецепт должен иметь название!"
            return false
        } catch {
            print("Что то пошло не так.")
            return false
        }
        return true
    }

    func throwRecipe() throws {
        guard !racipeName.isEmpty else { throw SaveRecipeError.emptyName }
    }

    func loadDishPicker(mainViewModel: RecipesViewModel) {
        if mainViewModel.dishPicker.name == "Все" {
            guard mainViewModel.dishs.count > 1 else {
                dishPicker = mainViewModel.dishPicker
                return
            }
            dishPicker = mainViewModel.dishs[1]
        } else {
            dishPicker = mainViewModel.dishPicker
        }
    }

    func dataВistribution(recipePicker: Recipe, dishs: [Dish]) {
        racipeName = recipePicker.name
        recipePicker.ingredients.forEach {ingredient in
            ingredients.append(ingredient)
        }
        cookingMethod = recipePicker.cookingMethod
        if let image = UIImage(data: recipePicker.Image) {
            imageStandard = Image(uiImage: image)
        }
        for dish in dishs {
            if dish.name == recipePicker.dish {
                dishPicker = dish
            }
        }
        loadedImage = MediaFile(data: recipePicker.Image)
    }

    var imageForPresentation: Image {
        if let loadedImage, let image = UIImage(data: loadedImage.data) {
            let image = Image(uiImage: image)
            return image
        } else {
            let image = imageStandard
            return image
        }
    }

    func convertPhoto(photo: PhotosPickerItem) {
        photo.loadTransferable(type: Data.self) { result in
            switch result {
                case .success(let data):
                    if let data,
                       let _ = UIImage(data: data) {
                        let loadedImage = MediaFile(data: data)
                        DispatchQueue.main.async {
                            self.loadedImage = loadedImage
                        }
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }

    func checkImage(recipePicker: Recipe) -> Bool {
        if let _ = UIImage(data: recipePicker.Image) {
            return true
        }
        return false
    }

}
