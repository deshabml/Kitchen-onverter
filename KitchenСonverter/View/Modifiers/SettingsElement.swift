//
//  BrackBoxElement.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 28.04.2023.
//

import SwiftUI

struct SettingsElement: ViewModifier {

    var verticalPadding: CGFloat = CGFloat(16)
    var horizontalPadding: CGFloat = CGFloat(16)
    var backgroundColor: Color
    var cornerRadius: CGFloat = CGFloat(18)
    var isClassic: Bool = true

    func body(content: Content) -> some View {
        if isClassic {
            content
                .padding(.vertical, verticalPadding)
                .padding(.horizontal, horizontalPadding)
                .background(backgroundColor)
                .cornerRadius(cornerRadius)
        } else {
            content
                .background(backgroundColor)
                .cornerRadius(cornerRadius)
                .padding(.vertical, verticalPadding)
                .padding(.horizontal, horizontalPadding)
        }
    }

}
