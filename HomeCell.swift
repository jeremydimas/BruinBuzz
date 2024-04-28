//
//  Home.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/17/24.
//

import SwiftUI

struct HomeCell: View {
    
    let cards: TripCard
    @State private var searchText: String = ""
    @State var showingBottomSheet = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 15) {
                HStack(spacing: 12) {
                    CardView(cards: cards)
                }
                .padding(15)
            }
        }
    }
}


struct HomeCell_Previews: PreviewProvider {
    static var previews: some View {
        HomeCell(cards: TripCard.tripCards[0])
    }
}
