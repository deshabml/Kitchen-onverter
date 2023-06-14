//
//  ConverterList.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 13.04.2023.
//

import SwiftUI

struct ConverterList: View {

    @StateObject var viewModel: ConverterListViewModel

    var body: some View {
        List {
            ForEach(0 ..< viewModel.recordedConverters.count, id: \.self) { item in
                ConverterCell(converter: viewModel.recordedConverters[item])
                    .background(.white.opacity(0.8))
                    .listRowInsets(EdgeInsets())
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Удалить") {
                            viewModel.completion(viewModel.recordedConverters[item])
                        }
                        .tint(.red)
                    }
            }.listRowBackground(Color.clear)
            Text("")
                .listRowBackground(Color.clear)
        }.listStyle(.plain)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(18)
        .ignoresSafeArea()
    }
    
}
