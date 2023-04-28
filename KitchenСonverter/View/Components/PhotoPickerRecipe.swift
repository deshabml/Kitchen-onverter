//
//  PhotoPickerRecipe.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 28.04.2023.
//

import SwiftUI
import PhotosUI

struct PhotoPickerRecipe: View {

    @Binding var selectedPhoto: PhotosPickerItem?
    var imageForPresentation: Image

    var body: some View {
        PhotosPicker(selection: $selectedPhoto, matching: .images) {
            imageForPresentation
                .resizable()
                .scaledToFill()
                .foregroundColor(.green)
                .frame(width: 150, height: 150)
                .cornerRadius(18)
                .shadow(color: .black, radius: 10)
        }
    }

}
