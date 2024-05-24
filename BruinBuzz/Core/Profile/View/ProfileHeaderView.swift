//
//  ProfileHeaderView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/27/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User
    @State private var showEditProfile = false
    @StateObject var viewModel: EditProfileViewModel
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        VStack(spacing: 10) {
            // Profile Image and Events

            HStack {
//                UserStatView(value: 3, title: "My\nEvents")
                CircularProfileImageView(imageUrl: viewModel.user.profileImageUrl, size: .large)
                .onAppear {
                        print("Circular profile view has been called in the current user profile")
                    }
//                UserStatView(value: 3, title: "Upcoming\nEvents")
            }
            // Name and biography
            VStack {
                Text(viewModel.fullname)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.black))
                Text(viewModel.bio)
                    .font(.subheadline)
                    .foregroundStyle(Color(.black))
                
            }
//            Text(user.username)
//                .foregroundStyle(Color(.white))
            
            Button{
                if user.isCurrentUser {
                    showEditProfile.toggle()
                } else {
                    print("Follow user")
                }
            } label: {
                Text(user.isCurrentUser ? "Edit Profile" : "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width:360, height: 32) //w:360
                    .background(user.isCurrentUser ? .black : Color.black.opacity(0.0))
                    .foregroundColor(user.isCurrentUser ? .white : .white)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(user.isCurrentUser ? .gray : .clear, lineWidth: 1)
                    )
            }
        }
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(viewModel: viewModel)
        }
        
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(user: User.MOCK_USERS[0])
    }
}
