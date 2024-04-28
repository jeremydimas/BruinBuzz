//
//  Home.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/17/24.
//

import SwiftUI

struct HomeCell: View {
    let post: TripCard
    
    @State private var searchText: String = ""
    @State var showingBottomSheet = false
    
    var body: some View
    {
        ScrollView(.vertical) {
            VStack(spacing: 15) {
                HStack(spacing: 12) {
                    HStack(spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)
                        TextField("Search", text: $searchText)
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
                }
                .modifier(CardGeometry())
            }
            .padding(15)
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
    
}

struct HomeCell_Previews: PreviewProvider {
    static var previews: some View {
        HomeCell(post: TripCard.tripCards[0])
    }
}
