//
//  ProfileHeaderView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/27/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User
    
    let twitterBlue = Color(UIColor(red: 0.016, green: 0.25, blue: 0.47, alpha: 1))

    
    @State private var showEditProfile = false
    
    var body: some View {
        VStack(spacing: 10) {
            // Profile Image and Events
            HStack {
//                UserStatView(value: 3, title: "My\nEvents")
                CircularProfileImageView(user: user, size: .large)
//                UserStatView(value: 3, title: "Upcoming\nEvents")
            }
            // Name and biography
            VStack {
                if let fullname = user.fullname {
                    Text(fullname)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                
                if let bio = user.bio {
                    Text(bio)
                        .font(.footnote)
                }
            }
            Text(user.username)
            
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
                    .background(user.isCurrentUser ? .white : Color.white.opacity(0.0))
                    .foregroundColor(user.isCurrentUser ? .black : .black)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(user.isCurrentUser ? .gray : .clear, lineWidth: 1)
                    )
            }
        }
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: user)
        }
        
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(user: User.MOCK_USERS[0])
    }
}
