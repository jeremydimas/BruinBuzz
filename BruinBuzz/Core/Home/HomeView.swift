//
//  HomeView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/27/24.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationStack {
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
//                TextField("Search", text: "$searchText")
            }
            Text("BruinBuzz")
                .font(Font.custom("MickeyMousePERSONALUSE-Regular", size: 25)).foregroundStyle(
                    LinearGradient(
                        colors: [.orange, .yellow, .orange],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(.ultraThinMaterial, in: .capsule)
            ScrollView {
                HomeCell(cards: TripCard.tripCards[0])
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
