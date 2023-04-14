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
                .foregroundColor(.black)
            Spacer()
            Text(converter.itog)
                .font(.custom("AvenirNext",
                              size: 20))
                .foregroundColor(.black)
            Text(converter.measuringSystem.name)
                .padding(.trailing, 16)
                .font(.custom("AvenirNext",
                              size: 20))
                .foregroundColor(.black)
        }
    }

}

struct ConverterCell_Previews: PreviewProvider {
    static var previews: some View {
        ConverterCell(converter: Converter(productName: "Молоко", itog: "10,000000", measuringSystem: MeasuringSystem(name: "Г", fullName: "грамм", isWeight: true)))
    }
}
