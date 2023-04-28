//
//  MainText.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 13.04.2023.
//

import SwiftUI

struct MainText: View {

    var text: String
    var size: Int = 24
    var isClassic: Bool = true

    var body: some View {
        if isClassic {
            Text(text)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .modifier(SettingsElement(horizontalPadding: 0,
                                          backgroundColor: .black.opacity(0.5)))
        } else {
            Text(text)
                .foregroundColor(.white)
                .font(.custom("AvenirNext-Bold",
                              size: CGFloat(size)))
        }
    }
    
}
