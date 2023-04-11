//
//  ContentView.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("MainBackgraund")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
