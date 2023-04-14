//
//  MainButton.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 14.04.2023.
//

import SwiftUI

struct MainButton: View {

    var text: String
    var colors: (Color, Color)
    var completion: ()->()

    var body: some View {
        Button {
            completion()
        } label: {
            Text(text)
                .padding(.vertical, 16)
                .foregroundColor(colors.0)
                .frame(maxWidth: .infinity)
                .background(colors.1)
                .cornerRadius(18)
        }
    }
}
