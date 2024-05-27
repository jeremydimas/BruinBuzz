//
//  CurrentUserProfileView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/26/24.
//

import SwiftUI

struct CurrentUserProfileView: View {
    let user: User
    
    @State private var showSideMenu = false
    @State private var profileState = ProfileViewState.sideMenu
    @StateObject private var viewModel: PostViewModel
    @State private var refreshedUser: User? = nil
    @Environment(\.colorScheme) var colorScheme
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: PostViewModel(user: user))
    }
    
    var body: some View {
        NavigationStack {
            
            
            ZStack {
                Color(colorScheme == .dark ? .black : .white)
                    .ignoresSafeArea()
                ScrollView {
                    // Header
                    
                    HStack(spacing: 125) {
                        
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.clear)
                            .font(.system(size: 24, weight: .bold))

                        Text("Profile")
                            .foregroundColor(.primary)
                            .fontWeight(.semibold)
                                                
                        Button {
                            withAnimation(.spring()) {
                                showSideMenu.toggle()
                            }
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(.primary)
                                .font(.system(size: 20, weight: .bold))

                        }
                    }
                    .padding(16)

                    ProfileHeaderView(user: user)

                    
                    PostView(user: refreshedUser ?? user)
                        .id(refreshedUser) // Ensure recreation of PostView when refreshedUser changes
                }
                .offset(x: showSideMenu ? -316 : 0) // Adjust the offset value as needed
                .shadow(color: showSideMenu ? .black : .clear, radius: 10)
                
                if showSideMenu {
                    SideMenuView(showSideMenu: $showSideMenu)
                        .transition(.move(edge: .trailing))
                        .zIndex(1)
                }
                    
            }

            .refreshable {
                print("refreshing..")
                do {
                    try await viewModel.fetchUserPosts()
                    refreshedUser = user // Update refreshedUser after fetching user posts
                } catch {
                    // Handle the error here, such as showing an alert to the user
                    print("Error fetching user posts: \(error)")
                }
                // Reset refreshedUser state after each refresh
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    refreshedUser = nil
                }
            }
        }
    }
}

struct CurrentUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfileView(user: User.MOCK_USERS[0])
    }
}
