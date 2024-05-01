//
//  CurrentUserProfileView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/26/24.
//

import SwiftUI

struct CurrentUserProfileView: View {
//    let post: TripCard
    let user: User
    
    var posts: [Post] {
        return Post.MOCK_POSTS.filter({ $0.user?.username == user.username })
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // Header
                ProfileHeaderView(user: user)
                
                // Post grid view
                Text("My Events")
                    .font(Font.custom("MickeyMousePERSONALUSE-Regular", size: 25)).foregroundStyle(
                        LinearGradient(
                            colors: [.orange, .yellow, .orange],
                            startPoint: .leading,
                            endPoint: .trailing)
                    )
                    .padding(.top, 15)
                    .padding(.bottom, 15)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack { // Adjust spacing between posts as needed
                        ForEach(posts) { post in
                            PostView(post: post) // Use PostView here
                                .frame(width: 400, height: 650)
            //                    .padding(.bottom)
                        }
                    }
                }

                
                Text("Upcoming Events")
                    .font(Font.custom("MickeyMousePERSONALUSE-Regular", size: 25)).foregroundStyle(
                        LinearGradient(
                            colors: [.orange, .yellow, .orange],
                            startPoint: .leading,
                            endPoint: .trailing)
                    )
                    .padding(.top, -30)
                    .padding(.bottom, 10)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack { // Adjust spacing between posts as needed
                        ForEach(posts) { post in
                            PostView(post: post) // Use PostView here
                                .frame(width: 400, height: 650)
            //                    .padding(.bottom)
                        }
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AuthService.shared.signout()
                    } label: {
                        Image(systemName: "arrowshape.forward.fill")
                            .foregroundColor(.black)
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
