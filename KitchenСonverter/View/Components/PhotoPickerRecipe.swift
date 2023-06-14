//
//  PhotoPickerRecipe.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 28.04.2023.
//

import SwiftUI
import PhotosUI

struct PhotoPickerRecipe: View {

    @StateObject var viewModel: PhotoPickerRecipeViewModel

    var body: some View {
        PhotosPicker(selection: $viewModel.selectedPhoto, matching: .images) {
            viewModel.imageForPresentation
                .resizable()
                .scaledToFill()
                .foregroundColor(.green)
                .frame(width: 150, height: 150)
                .cornerRadius(18)
                .shadow(color: .black, radius: 8)
        }
    }

}
