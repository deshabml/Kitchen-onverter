//
//  MainTextFild.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 13.04.2023.
//

import SwiftUI

struct MainTextFild: View {

    @StateObject var viewModel: MainTextFildViewModel
    var axis: Axis

    var body: some View {
        TextField(viewModel.placeHolder, text: $viewModel.bindingProperty, axis: axis)
            .foregroundColor(.black)
            .modifier(SettingsElement(backgroundColor: .white))
    }
    
}
