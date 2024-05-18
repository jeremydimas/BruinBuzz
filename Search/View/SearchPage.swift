//
//  SearchPage.swift
//  BruinBuzz
//
//  Created by Jeremy Dimas on 5/1/24.
//

import SwiftUI

struct SearchPage: View
{

    @State private var searchText = ""

    @StateObject var viewModel = SearchViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var isMainTabViewActive = false
    let twitterBlue = Color(UIColor(red: 0.016, green: 0.25, blue: 0.47, alpha: 1))

    
    var body: some View
    {
        NavigationStack
        {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [twitterBlue, .white]), center: .center, startRadius: 500, endRadius: -900)
                    .ignoresSafeArea()
                
                ScrollView {
                    HStack {
                        ZStack(alignment: .leading)
                        {
                            Capsule()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 40)
                                
                            HStack(spacing: 12)
                            {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 10)
                                TextField("Search", text: $searchText)
                                    .padding(.horizontal, -10)
                            }
                            .padding(.horizontal, 10)
                        }
                        .padding(.horizontal, 15)
                        .padding(.top, 10)
                        .padding(.bottom)
                        .offset(x:-10)
                        
                        Button(action: {
                            isMainTabViewActive = true
                            presentationMode.wrappedValue.dismiss()
                        })
                        {Text("Done")
                        .foregroundColor(.blue)}
                        .offset(x:-10)
                        .padding(.top, 10)
                        .padding(.bottom)
                }
                .padding(.horizontal)
                    
                    LazyVStack(spacing:12) {
                        ForEach(viewModel.users) {
                            user in NavigationLink(value:user) {
                                HStack {
                                    CircularProfileImageView(user:user, size: .small)
                                        
                                    Image(user.profileImageUrl ?? "")
                                        .resizable()
                                        .scaledToFill()
                                        .foregroundColor(.gray)
                                        .frame(width:40, height:40)
                                        .clipShape(Circle())

                                    VStack(alignment: .leading) {
                                        Text(user.username)
                                            .fontWeight(.semibold)
                                        if let fullname = user.fullname {
                                            Text(fullname)
                                        }
                                    }
                                    .font(.footnote)
                                    .offset(x:-40)
                                    Spacer()
                                }
                                .foregroundColor(.primary)
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.top,8)
                }
                .navigationDestination(for: User.self, destination: {user in ProfileView(user:user)
                })
            }
            

        }
    }
}
    
struct SearchPage_Previews: PreviewProvider
{
    static var previews: some View
    {
        SearchPage()
    }
}
