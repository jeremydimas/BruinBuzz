//
//  GuestTabView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 5/20/24.
//

import SwiftUI

struct GuestTabView: View {
    @StateObject var registrationViewModel = RegistrationViewModel()
    let twitterBlue = Color(UIColor(red: 0.494, green: 0.752, blue: 0.898, alpha: 1))
    @Environment(\.colorScheme) var colorScheme

    
    @State private var selectedIndex = 0
    var body: some View {
        TabView(selection: $selectedIndex) {
            HomeView()
                .onAppear() {
                    selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "house")
                }.tag(0)
            RequestUser()
                .environmentObject(registrationViewModel)
                .onAppear() {
                    selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "plus.square")
                }.tag(1)
            RequestUser()
                .environmentObject(registrationViewModel)
                .onAppear() {
                    selectedIndex = 2
                }
                .tabItem {
                    Image(systemName: "person")
                        
                }.tag(2)
        }
        .onAppear() {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = UIColor(Color("WB"))
            UITabBar.appearance().standardAppearance = tabBarAppearance
        }
        .tint(.primary)
    }
}

struct GuestTabView_Previews: PreviewProvider {
    static var previews: some View {
        GuestTabView()
    }
}
