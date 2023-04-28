//
//  AddRecipesViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 27.04.2023.
//

import SwiftUI
import PhotosUI

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

    func saveIngredient() {
        ingredients.append(ProductRecipe(name: ingredientsName, amount: ingredientsAmount, measuringSystem: ingredientsMeasuringSystem))
    }

    func deleteIngredient(product: ProductRecipe) {
        ingredients = ingredients.filter { $0 != product }
    }

    func saveRecipe(viewModel: RecipesViewModel) {
        guard let loadedImage = loadedImage else { return }
        viewModel.savingObject(object: Recipe(name: racipeName, Image: loadedImage.data, ingredients, cookingMethod: cookingMethod, dish: viewModel.dishPicker.name))
    }

}

extension AddRecipesViewModel {

    var imageForPresentation: Image {
        if let loadedImage, let image = UIImage(data: loadedImage.data) {
            let image = Image(uiImage: image)
            return image
        } else {
            let image = Image("RecipeIcons")
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

}
