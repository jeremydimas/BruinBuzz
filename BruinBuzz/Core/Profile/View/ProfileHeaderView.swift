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
                    .foregroundColor(.primary)
                    .padding(.leading,40)
                    .padding(.trailing,40)
                    .multilineTextAlignment(.center)
                Text(viewModel.bio)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .padding(.leading,40)
                    .padding(.trailing,40)
                    .multilineTextAlignment(.center)
                
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
                Text(user.isCurrentUser ? "Edit Profile" : "Follow")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width:360, height: 32) //w:360
                    // when the Follow feature has been implemented, use this one
//                    .background(user.isCurrentUser ? Color("LightMode") : Color("LightMode"))
                    // For now, use this one
                    .background(user.isCurrentUser ? Color("BW") : Color("WB"))
                    .ignoresSafeArea()
                    .foregroundColor(user.isCurrentUser ? Color("WB") : Color("WB"))

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
