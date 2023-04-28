//
//  AddButton.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 27.04.2023.
//

import SwiftUI

struct AddButton: View {

    var body: some View {
        HStack {
            Image(systemName: "plus")
                .resizable()
                .renderingMode(.template)
                .frame(width: 15, height: 15)
            Image("RecipeIcons")
                .resizable()
                .renderingMode(.template)
                .frame(width: 30, height: 30)
        }
        .padding()
        .background(.black.opacity(0.5))
        .cornerRadius(18, corners: [.topLeft, .bottomLeft])
        .foregroundColor(.green)
        .font(.headline)
    }
    
}
