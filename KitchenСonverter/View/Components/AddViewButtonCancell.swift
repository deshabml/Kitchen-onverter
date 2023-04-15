//
//  AddViewButtonCancell.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 15.04.2023.
//

import SwiftUI

struct AddViewButtonCancell: View {

    var completion: ()->()

    var body: some View {
        Button {
            completion()
        } label: {
            Text("Отмена")
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .foregroundColor(.black)
                .background(.white.opacity(0.8))
                .cornerRadius(12)
        }
        .padding(.horizontal, 16)
    }
    
}
