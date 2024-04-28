//
//  ProfileView.swift
//  BruinBuzz
//
//  Created by Jeremy Dimas on 4/18/24.
//

import SwiftUI

struct ProfileView: View {
    
    private let gridItems: [GridItem] = [
        .init(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // Header
                VStack(spacing: 10) {
                    // Profile Image and Events
                        HStack {
                            UserStatView(value: 3, title: "My\nEvents")
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            UserStatView(value: 3, title: "Upcoming\nEvents")
                        }
                    
                    // Name and biography
                    VStack/*(alignment:.leading, spacing: 4)*/ {
                        Text("Username")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Text("Additional Info")
                            .font(.footnote)
                    }
//                    .frame(maxWidth:.infinity, alignment: .leading)
//                    .padding(.horizontal)
                    
                    //action button
                    
                    Button{
                        
                    } label: {
                        Text("Edit Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(width:360, height: 32) //w:360
                            .foregroundColor(.black)
                            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray,lineWidth: 1))
                    }
                    Divider()
                }
                
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
                
                // change starts here
                
                .modifier(CardGeometry())
                Text("Upcoming Events")
                    .font(Font.custom("MickeyMousePERSONALUSE-Regular", size: 25)).foregroundStyle(
                        LinearGradient(
                            colors: [.orange, .yellow, .orange],
                            startPoint: .leading,
                            endPoint: .trailing)
                    )
                    .padding(.top, -30)
                    .padding(.bottom, 10)
                .modifier(CardGeometry())

                // change ends here
                
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

@ViewBuilder
func OverlayView(_ card: TripCard) -> some View{
    ZStack(alignment: .bottomLeading, content:{
        LinearGradient(colors:[
            .clear,
            .clear,
            .clear,
            .clear,
            .clear,
            .black.opacity(0.1),
            .black.opacity(0.5),
            .black
        ], startPoint: .top, endPoint: .bottom)

        VStack(alignment: .leading, spacing: 4, content: {
            Text(card.title)
                .font(.title2)
                .fontWeight(.black)
                .foregroundStyle(.white)
            Text(card.subtitle)
                .font(.callout)
                .foregroundStyle(.white.opacity(0.8))
        })
        .padding(20)
    })
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View{
        ProfileView()
    }
}
