//
//  MainAddButton.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 15.04.2023.
//

import SwiftUI

struct MainAddButton: View {

    var symbols: String
    var color: Color
    var isEdit: Bool
    var completion: ()->()

    var body: some View {
        Button {
            completion()
        } label: {
            HStack(alignment: .center,
                    spacing: 0) {
                if !isEdit {
                    Image(systemName: "plus")
                }
                Image(systemName: symbols)
            }
                    .foregroundColor(color)
                    .font(.headline)
                    .padding(10)
        }
    }
    
}
