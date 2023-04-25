//
//  RecipesView.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 21.04.2023.
//

import SwiftUI

struct RecipesView: View {

    @StateObject var viewModel = RecipesViewModel()

    var body: some View {
        VStack {
            Text("Тут будут рецепты!")
                .foregroundColor(.white)
                .font(.custom("AvenirNext-Bold",
                              size: CGFloat(20)))
            MainButton(text: "KNOPKA", colors: (.white, .green)) {
//                guard let recepes = viewModel.recepes else { return }
                print(viewModel.recepes[0])
            }
            .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("RecipesBackgraund")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
        )
        .onAppear {
            viewModel.getData()
        }
    }

}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
