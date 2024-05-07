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
    
    var body: some View {
        NavigationStack {
            // Search Bar
            Text("BRUINBUZZ")
                .font(Font.custom("NexaRustSans-Trial-Black2", size: 20))
                .foregroundColor(.primary)
                .padding(.bottom, 5)
                .padding(.top, 20)
                .padding(.leading, -180) // Adjust this value as needed
            
            ZStack(alignment: .leading) {
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
                        .onTapGesture
                        {
                            isSearching = true // Set searching state to true when tapped
                        }
                }
                .padding(.horizontal, 10)
            }
            .padding(.horizontal, 30)
            .padding(.bottom)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.posts) { post in
                        HomeCell(post: post)
                            .frame(width: 430)
                        
                          
                    }
                }
                
                Spacer()
            }
        
        }
        .fullScreenCover(isPresented: $isSearching)
        {
            SearchPage()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

