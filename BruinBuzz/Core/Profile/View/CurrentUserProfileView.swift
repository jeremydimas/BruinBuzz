//
//  CurrentUserProfileView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/26/24.
//

import SwiftUI

struct CurrentUserProfileView: View {
    let user: User
    let twitterBlue = Color(UIColor(red: 0.016, green: 0.25, blue: 0.47, alpha: 1))
    @State private var showSideMenu = false
    @State private var profileState = ProfileViewState.sideMenu
    
    @StateObject private var viewModel: PostViewModel
    @State private var refreshedUser: User? = nil
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: PostViewModel(user: user))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [twitterBlue, .white]), center: .center, startRadius: 500, endRadius: -900)
                    .ignoresSafeArea()
                

                
                ScrollView {
                    // Header
                    
                    HStack(spacing: 125) {
                        
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.clear)
                        
                        Text("Profile")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                                                
                        Button {
                            withAnimation(.spring()) {
                                showSideMenu.toggle()
                            }
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(.white)
                        }
                    }
                    .padding(16)


                    
                    ProfileHeaderView(user: user)

                    
                    PostView(user: refreshedUser ?? user)
                        .id(refreshedUser) // Ensure recreation of PostView when refreshedUser changes
                }
//                .navigationTitle("Profile")
    //            .foregroundColor(.primary)
    //            .navigationBarTitleDisplayMode(.inline)
                .offset(x: showSideMenu ? -316 : 0) // Adjust the offset value as needed
                .shadow(color: showSideMenu ? .black : .clear, radius: 10)
                
                if showSideMenu {
                    SideMenuView(showSideMenu: $showSideMenu)
                        /*.background(Color.white)*/ // Ensure SideMenuView has a background
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


//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button {
//                            AuthService.shared.signout()
//                        } label: {
//                            Image(systemName: "arrowshape.forward.fill")
//                                .foregroundColor(.primary)
//                        }
//                    }
//
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button {
//                            Task {
//                                 AuthService.shared.deleteUserData()
//                                 try await AuthService.shared.deleteAccount()
//                            }
//                        } label: {
//                            Image(systemName: "xmark.app.fill")
//                                .foregroundColor(.primary)
//                        }
//                    }
//                }

struct CurrentUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfileView(user: User.MOCK_USERS[0])
    }
}
