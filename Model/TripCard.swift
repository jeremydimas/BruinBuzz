//
//  TripCard.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/16/24.
//

import SwiftUI

/// Trip Card Model
struct TripCard: Identifiable, Hashable {
    var id: UUID = .init()
    var title: String
    var subtitle: String
    var image: String
}

/// Sample Cards
var tripCards: [TripCard] = [
    .init(title: "London", subtitle: "England", image: "Pic 1"),
    .init(title: "New York", subtitle: "USA", image: "Pic 2"),
    .init(title: "Prague", subtitle: "Czech Republic", image: "Pic 3"),
]
