//
//  ShowScreenSettingsElement.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 06.05.2023.
//

import SwiftUI

struct ShowScreenSettingsElement: ViewModifier {

    var imageName: String

    func body(content: Content) -> some View {
        content
            .background {
                Image(imageName)
            }
            .transition(.move(edge: .bottom))
            .cornerRadius(18)
            .shadow(radius: 2)
            .padding()
    }

}
