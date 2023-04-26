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
            VStack {
                Picker("Единици измерения", selection: $viewModel.dishPicker) {
                    ForEach(Dish.allCases, id: \.self) { dish in
                        Text(dish.description).tag(dish)
                            .foregroundColor(.white)
                    }
                }
                //                    .frame(width: 1000)
                .pickerStyle(.wheel)
                .background(.black)
                .cornerRadius(18)

                RecipesGrid(recipes: $viewModel.recipesPicker)
            }
            .padding(.horizontal, 16)
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
