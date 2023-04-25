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
            RecipesGrid(recipes: $viewModel.recipes)
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
        NavigationView {
            RecipesView()
        }
    }
}
