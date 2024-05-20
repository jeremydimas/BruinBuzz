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
//    let twitterBlue = Color(UIColor(red: 0.016, green: 0.25, blue: 0.47, alpha: 1))
    let twitterBlue = Color(UIColor(red: 0.494, green: 0.752, blue: 0.898, alpha: 1))

    
    var body: some View
    {
        NavigationStack
        {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [ .white]), center: .center, startRadius: 500, endRadius: -900)
                    .ignoresSafeArea()
                
                ScrollView {
                    HStack {
                        ZStack(alignment: .leading)
                        {
                            Capsule()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 40)
                            
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 10)
                                
                                ZStack(alignment: .leading) {
                                    if searchText.isEmpty {
                                        Text("Search")
                                            .foregroundColor(Color(.lightGray)) // Set the color of the placeholder text
                                            .autocapitalization(.none)
                                        
                                    }
                                    TextField("", text: $searchText)
                                        .foregroundStyle(Color(.gray))
                                        .accentColor(.black)
                                        .autocapitalization(.none)
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                        .padding(.horizontal, 15)
                        .padding(.top, 10)
                        .padding(.bottom)
                        .offset(x:-10)
                        
                        Button {
                            isMainTabViewActive = true
                            presentationMode.wrappedValue.dismiss()
                        } label : {
                            Text("Done")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .offset(x:-10)
                                .padding(.top, 10)
                                .padding(.bottom)
                        }
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
                                        .foregroundColor(.black)
                                        .frame(width:40, height:40)
                                        .clipShape(Circle())

                                    VStack(alignment: .leading) {
                                        Text(user.username)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(Color(.black))
                                        if let fullname = user.fullname {
                                            Text(fullname)
                                                .foregroundStyle(Color(.black))
                                        }
                                    }
                                    .font(.footnote)
                                    .offset(x:-40)
                                    Spacer()
                                }
                                .foregroundColor(.black)
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
