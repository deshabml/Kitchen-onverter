//
//  RecipesView.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 21.04.2023.
//

import SwiftUI

struct RecipesView: View {

    var body: some View {
        VStack {
            Text("Тут будут рецепты!")
                .foregroundColor(.white)
                .font(.custom("AvenirNext-Bold",
                              size: CGFloat(20)))
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("RecipesBackgraund")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
        )
    }

}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
