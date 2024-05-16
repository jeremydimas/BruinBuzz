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
    
    // start date information
    let startMM: String
    let startDD: String
    let startYYYY: String
    
    // end date information
    let endMM: String
    let endDD: String
    let endYYYY: String
    
    // time information
    let starttime: String
    let endtime: String
    
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
            
            startMM: "12",
            startDD: "18",
            startYYYY: "2003",
            
            endMM: "05",
            endDD: "09",
            endYYYY: "2024",
            
            starttime: "10:37",
            endtime: "9:33"
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
            
            startMM: "12",
            startDD: "18",
            startYYYY: "2003",
            
            endMM: "05",
            endDD: "09",
            endYYYY: "2024",
            
            starttime: "10:37",
            endtime: "9:33"

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
            
            startMM: "12",
            startDD: "18",
            startYYYY: "2003",
            
            endMM: "05",
            endDD: "09",
            endYYYY: "2024",
            
            starttime: "10:37",
            endtime: "9:33"

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
            
            startMM: "12",
            startDD: "18",
            startYYYY: "2003",
            
            endMM: "05",
            endDD: "09",
            endYYYY: "2024",
            
            starttime: "10:37",
            endtime: "9:33"
        )
        
    ]
}

