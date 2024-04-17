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
    .init(title: "Bruin Walk", subtitle: "UCLA", image: "UCLA1"),
    .init(title: "Wilson Plaza", subtitle: "UCLA", image: "UCLA2"),
    .init(title: "Powell Library", subtitle: "UCLA", image: "UCLA3"),
]
