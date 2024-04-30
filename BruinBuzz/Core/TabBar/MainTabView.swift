//
//  MainTabView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/17/24.
//
import SwiftUI
struct MainTabView: View {
    let user: User

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
            UploadPostView(tabIndex: $selectedIndex)
                .onAppear() {
                    selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "plus.square")
                }.tag(1)
            CurrentUserProfileView(user: user)
                .onAppear() {
                    selectedIndex = 2
                }
                .tabItem {
                    Image(systemName: "person")
                }.tag(2)
        }
        .accentColor(.black)
    }
}
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(user: User.MOCK_USERS[0])
    }
}