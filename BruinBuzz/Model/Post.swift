//
//  TripCard.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/16/24.
//

import Foundation

struct Post: Identifiable, Hashable, Codable {
    let id: String
    let ownerUid: String
    let imageUrl: String
    let caption: String
    var user: User?
    let title: String
    let location: String
    let organizer: String
    let organization: String
}

extension Post {
    static var MOCK_POSTS: [Post] = [
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            imageUrl: "UCLA1",
            caption: "UCLA",
            user: User.MOCK_USERS[0],
            title: "Bruin Walk",
            location: "ucla",
            organizer: "gene block",
            organization: "charity"
        ),
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            imageUrl: "UCLA2",
            caption: "UCLA",
            user: User.MOCK_USERS[1],
            title: "Royce",
            location: "ucla",
            organizer: "gene block",
            organization: "charity"

        ),
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            imageUrl: "UCLA2",
            caption: "UCLA",
            user: User.MOCK_USERS[1],
            title: "Royce",
            location: "ucla",
            organizer: "gene block",
            organization: "charity"

        ),
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            imageUrl: "UCLA3",
            caption: "UCLA",
            user: User.MOCK_USERS[2],
            title: "Wilson",
            location: "ucla",
            organizer: "gene block",
            organization: "charity"
        )
        
    ]
}

