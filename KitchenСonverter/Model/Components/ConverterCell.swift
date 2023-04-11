//
//  ConverterCell.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//

import SwiftUI

struct ConverterCell: View {

    let converter: Converter

    var body: some View {
        HStack {
            Text(converter.productName)
                .padding()
                .font(.custom("AvenirNext",
                              size: 20))
                .foregroundColor(.white)
            Spacer()
            Text(converter.itog)
                .padding()
                .font(.custom("AvenirNext",
                              size: 20))
                .foregroundColor(.white)

        }
    }
}

struct ConverterCell_Previews: PreviewProvider {
    static var previews: some View {
        ConverterCell(converter: Converter(productName: "Молоко", itog: "3,000000"))
    }
}
