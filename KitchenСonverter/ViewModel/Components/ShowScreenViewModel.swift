//
//  ShowScreenViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 06.05.2023.
//

import SwiftUI

class ShowScreenViewModel: ObservableObject {

    @Published var isShow: Bool = false
    var imageName: String

    init(imageName: String) {
        self.imageName = imageName
    }

}
