//
//  CurrentUserProfileView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/26/24.
//

import SwiftUI

struct CurrentUserProfileView: View {
    let user: User
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // Header
                ProfileHeaderView(user: user)
                
                // Post grid view
                Text("My Events")
                    .font(Font.custom("NexaRustSans-Trial-Black2", size: 20))
                    .foregroundStyle(Color(.black))
                    .padding(.top, 15)
                    .padding(.bottom, 1)
                    .padding(.leading, -180) // Adjust this value as needed
                
//                    .padding(.bottom, 10)
                
                    PostView(user: user)
                
                Text("Upcoming Events")
                    .font(Font.custom("NexaRustSans-Trial-Black2", size: 20))
                    .foregroundStyle(Color(.black))
                    .padding(.leading, -145) // Adjust this value as needed
                    .padding(.top, -15)
                    .padding(.bottom, 1)
                
                /*ScrollView(.horizontal, showsIndicators: false)*/
                    PostView(user: user)

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
