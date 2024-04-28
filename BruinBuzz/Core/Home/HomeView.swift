//
//  HomeView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/27/24.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            // Inside your view body
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.gray.opacity(0.2)) // Use gray color with opacity
                    .frame(height: 40) // Adjust the height as needed
                
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

            
            
            ScrollView {
                HomeCell(cards: TripCard.tripCards)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
