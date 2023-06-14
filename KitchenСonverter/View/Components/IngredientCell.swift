//
//  IngredientCell.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 27.04.2023.
//

import SwiftUI

struct IngredientCell: View {

    let product: ProductRecipe

    var body: some View {
        HStack {
            Text(product.name)
                .padding()
            Spacer()
            Text(product.amount)
            Text(product.measuringSystem)
                .padding(.trailing, 16)
        }
        .font(.custom("AvenirNext",
                      size: 20))
        .foregroundColor(.black)
    }

}
