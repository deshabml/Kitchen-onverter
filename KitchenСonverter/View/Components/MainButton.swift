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
    var isCancelStyle: Bool = false

    var body: some View {
        Button {
            completion()
        } label: {
            if isCancelStyle {
                Text(text)
                    .foregroundColor(colors.0)
                    .modifier(SettingsElement(verticalPadding: 8, horizontalPadding: 16, backgroundColor: colors.1.opacity(0.8), cornerRadius: 12))
            } else {
                Text(text)
                    .foregroundColor(colors.0)
                    .frame(maxWidth: .infinity)
                    .modifier(SettingsElement(horizontalPadding: 0,
                                              backgroundColor: colors.1))
            }
        }
        .padding(.horizontal, isCancelStyle ? 16 : 0)
    }
    
}
