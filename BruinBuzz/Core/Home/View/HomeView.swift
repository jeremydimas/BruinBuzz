//
//  HomeView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/27/24.
//

import SwiftUI
import Foundation

struct HomeView: View {
    
    
    // Fetch Feed
    @StateObject var viewModel = HomeViewModel()
    @State private var isSearching: Bool = false
        // Ends here
    
    @State private var searchText: String = ""
    let twitterBlue = Color(UIColor(red: 0.016, green: 0.25, blue: 0.47, alpha: 1))
    
    var body: some View {
        NavigationStack {
            // Search Bar
            ZStack {
                RadialGradient(gradient: Gradient(colors: [twitterBlue, .white]), center: .center, startRadius: 500, endRadius: -900)
                    .ignoresSafeArea()
                
                VStack {
                    Text("BRUINBUZZ")
                        .font(Font.custom("NexaRustSans-Trial-Black2", size: 20))
                        .foregroundColor(.primary)
                        .padding(.bottom, 5)
                        .padding(.top, 20)
                    .padding(.leading, -180)
                    
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 40)
                        
                        HStack(spacing: 12) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 10)
                            
                            TextField("Search", text: $searchText)
                                .padding(.horizontal, -10)
                                .onTapGesture {
                                    isSearching = true // Set searching state to true when tapped
                                }
                        }
                        .padding(.horizontal, 10)
                    }
                    .padding(.horizontal, 30)
        //            .padding(.bottom)
                    
                    Text("All Events")
                        .font(Font.custom("NexaRustSans-Trial-Black2", size: 20))
                        .foregroundColor(.primary)
                        .padding(.top, 10)
                        .padding(.bottom, 1)
                        .padding(.leading, -180) // Adjust this value as needed
                    
                    ScrollView {
                        ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(viewModel.posts) { post in
                                        HomeCell(post: post)
                                            .frame(width: 430)
                                    }
                                }
                        }
                    }
                    .refreshable {
                        do {
                            try await viewModel.fetchPosts()
                        }   catch {
                            // Handle the error here, you can log it or display an alert to the user
                                print("Error fetching posts: \(error)")
                            }
                    }

                    Spacer()
                }
                
                
                
                
            } // Adjust this value as needed
            
            
        }
        .fullScreenCover(isPresented: $isSearching) {
            SearchPage()
        }
    }
    
}

struct Refresh {
    var startOffset: CGFloat = 0
    var offset: CGFloat = 0
    var started: Bool
    var released: Bool
    var invalid: Bool = false
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

