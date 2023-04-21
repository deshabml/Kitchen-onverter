//
//  MainAddButton.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 15.04.2023.
//

import SwiftUI



struct MainAddLabel: View {

    var isEdit: Bool
    var symbols: String
    var color: Color

    var body: some View {
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
