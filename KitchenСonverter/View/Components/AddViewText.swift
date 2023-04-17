//
//  AddViewText.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 15.04.2023.
//

import SwiftUI

struct AddViewText: View {

    var text: String
    var size: Int

    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .font(.custom("AvenirNext-Bold",
                          size: CGFloat(size)))
    }
    
}

struct AddViewText_Previews: PreviewProvider {
    static var previews: some View {
        AddViewText(text: "Добавление", size: 30)
    }
}
