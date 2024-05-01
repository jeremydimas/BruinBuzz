//
//  HomeView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/27/24.
//

import SwiftUI

struct HomeView: View 
{
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View 
    {
        NavigationStack 
        {
            // Search Bar
            VStack
            {
                ZStack(alignment: .leading)
                {
                    Capsule()
                        .fill(Color.gray.opacity(0.2)) // Use gray color with opacity
                        .frame(height: 40) // Adjust the height as needed
                        
                    
                    HStack(spacing: 12)
                    {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.horizontal, 10)
                        
                        TextField("Search", text: $searchText)
                            .padding(.horizontal, -10)
                            .onTapGesture
                            {
                                isSearching = true // Set searching state to true when tapped
                            }
                    }
                    .padding(.horizontal, 10)
                }
                .padding(.horizontal, 30)
                .padding(.top, 10)
                .padding(.bottom)
                
                ScrollView(.horizontal, showsIndicators: false)
                {
                    HStack
                    { // Adjust spacing between posts as needed
                        ForEach(Post.MOCK_POSTS) { post in
                            HomeCell(post: post)
                                .frame(width: 400) // Adjust post width as needed
                        }
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $isSearching) 
        {
            // Your search page view goes here
            SearchPage()
        }
    }
}



struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

