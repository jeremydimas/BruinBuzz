//
//  CurrentUserProfileView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/26/24.
//

import SwiftUI

struct CurrentUserProfileView: View {
    let user: User
        
    @StateObject private var viewModel: PostViewModel
    
    let twitterBlue = Color(UIColor(red: 0.016, green: 0.25, blue: 0.47, alpha: 1))
    
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
                    ProfileHeaderView(user: user)
                    
                    PostView(user: refreshedUser ?? user)
                        .id(refreshedUser) // Ensure recreation of PostView when refreshedUser changes
                }
                .navigationTitle("Profile")
                .foregroundColor(.primary)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            AuthService.shared.signout()
                        } label: {
                            Image(systemName: "arrowshape.forward.fill")
                                .foregroundColor(.primary)
                        }
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
                    DispatchQueue.main.asyncAfter(deadline: .now() /*+ 1*/) {
                        refreshedUser = nil
                    }
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
