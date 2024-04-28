//
//  CardView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/27/24.
//

import SwiftUI

struct CardView: View {
    let cards: [TripCard] // Change to array
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ScrollView(.horizontal) {
                HStack(spacing: 5) {
                    ForEach(cards) { card in // Loop through cards array
                        GeometryReader { proxy in
                            let cardSize = proxy.size
                            let minX = min((proxy.frame(in: .scrollView).minX - 30) * 1.4, proxy.size.width * 1.4)
                            Image(card.imageUrl) // Use card instead of cards
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .offset(x: -minX)
                                .frame(width: proxy.size.width * 2.5)
                                .frame(width: cardSize.width, height: cardSize.height)
                                .overlay {
                                    OverlayView(card) // Use card instead of cards
                                }
                                .clipShape(.rect(cornerRadius: 15))
                                .shadow(color: Color.black.opacity(0.25), radius: 8, x: 5, y: 10)
                        }
                        .frame(width: size.width - 60, height: size.height - 50)
                        .scrollTransition(.interactive, axis: .horizontal) { view, phase in
                            view.scaleEffect(phase.isIdentity ? 1 : 0.95)
                        }
                    }
                }
                .padding(.horizontal, 30)
                .scrollTargetLayout()
                .frame(height: size.height, alignment: .top)
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
        }
        /*.frame(height: 400)*/ // Adjust the height as needed
        .padding(.horizontal, -15)
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


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide an array of TripCard instances for preview
        CardView(cards: TripCard.tripCards)
    }
}

