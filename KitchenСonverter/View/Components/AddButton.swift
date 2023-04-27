//
//  AddButton.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 27.04.2023.
//

import SwiftUI

struct AddButton: View {
    var body: some View {
        Button {
            print("karamba")
        } label: {
            HStack {
                Image(systemName: "plus")
                Image("RecipeIcons")
            }
                .foregroundColor(.yellow)
                .font(.headline)
                .padding(10)
        }

    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton()
    }
}
