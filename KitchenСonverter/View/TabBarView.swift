//
//  TabBarView.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 21.04.2023.
//

import SwiftUI

struct TabBarView: View {

    @State var tabBarItem = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $tabBarItem) {
                NavigationView {
                    CalculatorView()
                }
                    .tag(0)
                RecipesView()
                    .tag(1)
            }
            ZStack{
                HStack{
                    ForEach((TabBarItems.allCases), id: \.self){ item in
                        Button{
                            tabBarItem = item.rawValue
                        } label: {
                            CustomTabItem(imageName: item.iconName, title: item.title, isActive: (tabBarItem == item.rawValue))
                        }
                    }
                }
                .padding(6)
            }
            .frame(height: 66)
            .background(.green.opacity(0.6))
            .cornerRadius(18)
            .padding(.horizontal, 16)
            .animation(.easeInOut(duration: 0.3), value: tabBarItem)
        }
        .onAppear {
            UITabBar.appearance().isHidden = true
        }
    }

}

extension TabBarView {

    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View {
        HStack(spacing: 10) {
            Spacer()
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .white)
                .frame(width: isActive ? 40 : 30, height: isActive ? 40 : 30)
            if isActive{
                Text(title)
                    .foregroundColor(.black)
            }
            Spacer()
        }
        .frame(width: isActive ? CGFloat(title.count * 14 + 60) : 40, height: 60)
        .background(isActive ? .yellow.opacity(0.8) : .clear)
        .cornerRadius(18)
    }

}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
