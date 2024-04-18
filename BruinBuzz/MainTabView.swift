//
//  MainTabView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/17/24.
//
import SwiftUI
struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationView {
                Home()
            }
            .tabItem {
                Image(systemName: "house")
            }
            Text("Upload Post")
                .tabItem {
                    Image(systemName: "plus.square")
                }
            Text("Profile")
                .tabItem {
                    Image(systemName: "person")
                }
        }
        .accentColor(.black)
    }
}
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
