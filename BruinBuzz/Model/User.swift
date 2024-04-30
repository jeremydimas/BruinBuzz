//
//  User.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/22/24.
//

import Foundation
import Firebase

struct User: Identifiable, Hashable, Codable {
    let id: String
    var username: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    let email: String
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(
            id: NSUUID().uuidString, 
            username: "yd1mas",
            profileImageUrl: nil,
            fullname: "Harry Potter",
            bio: "Fuck around, find out",
            email: "yd1mas@outlook.com"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "peter",
            profileImageUrl: nil,
            fullname: "Peter Andrews",
            bio: "Hi, I am Peter",
            email: "peter@gmail.com"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "jack",
            profileImageUrl: nil,
            fullname: "Jack Black",
            bio: "Kung Fu Panda",
            email: "po@gmail.com"
        )
    ]
}
