//
//  ShowScreen.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 06.05.2023.
//

import SwiftUI

struct ShowScreen<Content: View>: View {
    
    @EnvironmentObject var mainViewModel: CalculatorViewModel
    @StateObject var viewModel: ShowScreenViewModel
    var screen: Content
    
    var body: some View {
        if viewModel.isShow {
            Rectangle()
                .ignoresSafeArea()
                .opacity(0.6)
            screen
                .environmentObject(mainViewModel)
                .modifier(ShowScreenSettingsElement(imageName: viewModel.imageName))
        }
    }
    
}
