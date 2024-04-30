//
//  ProfileView.swift
//  BruinBuzz
//
//  Created by Jeremy Dimas on 4/18/24.
//

import SwiftUI

struct ProfileView: View {
    
    let user: User

    var cards: [TripCard] {
        return TripCard.tripCards.filter({ $0.user?.username == user.username })
    }
    
    var body: some View {
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
                CardView(cards: cards) // Pass the array of TripCard instances
                
                Text("Upcoming Events")
                    .font(Font.custom("MickeyMousePERSONALUSE-Regular", size: 25)).foregroundStyle(
                        LinearGradient(
                            colors: [.orange, .yellow, .orange],
                            startPoint: .leading,
                            endPoint: .trailing)
                    )
                    .padding(.top, -30)
                    .padding(.bottom, 10)
                // Pass the array of TripCard instances again
                CardView(cards: cards)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
    }
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View{
        ProfileView(user: User.MOCK_USERS[1])
    }
}
