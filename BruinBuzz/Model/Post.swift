//
//  TripCard.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/16/24.
//

import Foundation

import Firebase
import FirebaseFirestoreSwift

struct Post: Identifiable, Hashable, Codable {
    // identification
    @DocumentID var id: String?
    let ownerUid: String
    let imageUrl: String
    
    // post information
    let caption: String
    var rsvp: Int
    let timestamp: Timestamp
    
    var user: User?
    let title: String
    let location: String
    let organizer: String
    let organization: String
    
    let currentTime: String?
    let pastTime: String?
    
    let link1: String?
    let link2: String?
//    let link3: String
    
    // rsvp
    var didRsvp: Bool? = false
    
}

extension Post {
    static var MOCK_POSTS: [Post] = [
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            imageUrl: "UCLA1",
            caption: "UCLA",
            rsvp: 0,
            timestamp: Timestamp(),
            user: User.MOCK_USERS[0],
            title: "Bruin Walk",
            location: "ucla",
            organizer: "gene block",
            organization: "charity",
            currentTime: "morning",
            pastTime: "goodnight",
            link1: "https",
            link2: "https"
//            link3: "https",

        ),
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            imageUrl: "UCLA2",
            caption: "UCLA",
            rsvp: 0,
            timestamp: Timestamp(),
            user: User.MOCK_USERS[1],
            title: "Royce",
            location: "ucla",
            organizer: "gene block",
            organization: "charity",
            currentTime: "morning",
            pastTime: "goodnight",
            link1: "https",
            link2: "https"
//            link3: "https",

        ),
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            imageUrl: "UCLA2",
            caption: "UCLA",
            rsvp: 0,
            timestamp: Timestamp(),
            user: User.MOCK_USERS[1],
            title: "Royce",
            location: "ucla",
            organizer: "gene block",
            organization: "charity",
            currentTime: "morning",
            pastTime: "goodnight",
            link1: "https",
            link2: "https"
//            link3: "https",


        ),
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            imageUrl: "UCLA3",
            caption: "UCLA",
            rsvp: 0,
            timestamp: Timestamp(),
            user: User.MOCK_USERS[2],
            title: "Wilson",
            location: "ucla",
            organizer: "gene block",
            organization: "charity",
            currentTime: "morning",
            pastTime: "goodnight",
            link1: "https",
            link2: "https"
//            link3: "https",

        )
        
    ]
}

