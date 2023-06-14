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
            Text(converter.product?.name ?? "")
                .padding()
            Spacer()
            Text(converter.itog)
            Text(converter.measuringSystem?.name ?? "")
                .padding(.trailing, 16)
        }
        .font(.custom("AvenirNext",
                      size: 20))
        .foregroundColor(.black)
    }

}

struct ConverterCell_Previews: PreviewProvider {
    static var previews: some View {
        ConverterCell(converter: Converter(product: Product(name: "Молоко", density: 1.027), itog: "10,000000", measuringSystem: MeasuringSystem(name: "Г", isWeight: true, ratio: 1)))
    }
}
