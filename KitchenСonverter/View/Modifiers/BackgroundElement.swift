//
//  BackgroundElement.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 28.04.2023.
//

import SwiftUI

struct BackgroundElement: ViewModifier {

    var ImageName: String
    var onApperComplition: (()->())?

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarBackButtonHidden(true)
            .background(
                Image(ImageName)
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
            )
            .onAppear {
                onApperComplition?()
            }
    }

}
