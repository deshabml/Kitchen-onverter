//
//  alertElement.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 28.04.2023.
//

import SwiftUI

struct AlertElement: ViewModifier {

    var TextFirst: String
    @Binding var switchAlertFirst: Bool
    var TextSecond: String
    @Binding var switchAlertSecond: Bool
    var complitionAlertSecond: ()->()

    func body(content: Content) -> some View {
        content
            .alert(TextFirst, isPresented: $switchAlertFirst) {
                Button("ОК") { }
            }
            .alert(TextSecond, isPresented: $switchAlertSecond) {
                Button("ОТМЕНА", role: .cancel) { }
                Button("УДАЛИТЬ", role: .destructive) {
                    complitionAlertSecond()
                }
            }
    }

}

