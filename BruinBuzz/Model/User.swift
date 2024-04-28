//
//  User.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/22/24.
//

import Foundation

struct User: Identifiable, Hashable, Codable {
    let id: String
    var username: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    let email: String
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(
            id: NSUUID().uuidString, 
            username: "yd1mas",
            profileImageUrl: "UCLA1",
            fullname: "Harry Potter",
            bio: "Fuck around, find out",
            email: "yd1mas@outlook.com"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "peter",
            profileImageUrl: "UCLA2",
            fullname: "Peter Andrews",
            bio: "Hi, I am Peter",
            email: "peter@gmail.com"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "jack",
            profileImageUrl: "UCLA3",
            fullname: "Jack Black",
            bio: "Kung Fu Panda",
            email: "po@gmail.com"
        )
    ]
}
