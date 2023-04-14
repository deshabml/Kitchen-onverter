//
//  MainText.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 13.04.2023.
//

import SwiftUI

struct MainText: View {

    var text: String

    var body: some View {
        Text(text)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .foregroundColor(.white)
            .background(.black.opacity(0.5))
            .cornerRadius(18)
    }
}

struct MainText_Previews: PreviewProvider {
    static var previews: some View {
        MainText(text: "0,000000")
    }
}
