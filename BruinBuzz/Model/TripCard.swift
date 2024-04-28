//
//  TripCard.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/16/24.
//

import Foundation

struct TripCard: Identifiable, Hashable, Codable {
    let id: String
    let ownerUid: String
    let imageUrl: String
    var user: User?
    let title: String
    let subtitle: String
}

extension TripCard {
    static var tripCards: [TripCard] = [
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            imageUrl: "UCLA1",
            user: User.MOCK_USERS[0],
            title: "Bruin Walk",
            subtitle: "UCLA"
        ),
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            imageUrl: "UCLA2",
            user: User.MOCK_USERS[1],
            title: "Bruin Walk",
            subtitle: "UCLA"
        ),
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            imageUrl: "UCLA3",
            user: User.MOCK_USERS[2],
            title: "Bruin Walk",
            subtitle: "UCLA"
        )
        
    ]
}

