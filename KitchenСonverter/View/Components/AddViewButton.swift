//
//  AddViewButtonCancell.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 15.04.2023.
//

import SwiftUI

struct AddViewButton: View {

    var text: String
    var colors: (Color, Color)
    var completion: ()->()

    var body: some View {
        Button {
            completion()
        } label: {
            Text(text)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .foregroundColor(colors.0)
                .background(colors.1.opacity(0.8))
                .cornerRadius(12)
        }
        .padding(.horizontal, 16)
    }
    
}
