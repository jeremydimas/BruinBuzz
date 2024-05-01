//
//  HomeView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/27/24.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText: String = ""
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            // Search Bar
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
                }
                .padding(.horizontal, 10)
            }
            .padding(.horizontal, 30)
            .padding(.top, 10)
            .padding(.bottom)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack { // Adjust spacing between posts as needed
                    ForEach(Post.MOCK_POSTS) { post in
                        HomeCell(post: post)
                            .frame(width: 400) // Adjust post width as needed
                    }
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

