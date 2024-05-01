//
//  UserService.swift
//  BruinBuzz
//
//  Created by Jeremy Dimas on 5/1/24.
//

import Foundation
import Firebase

struct UserService
{
//    @MainActor
    static func fetchAllUsers() async throws -> [User]{
//        var users = [User]()
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
//        let documents = snapshot.documents
        return snapshot.documents.compactMap({try? $0.data(as:User.self)})
        
//        for doc in documents{
//            guard let user = try? doc.data(as: User.self) else{return users}
//            users.append(user)
//            print(doc.data())
//        }
//        return users
    }
}
