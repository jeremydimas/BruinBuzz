//
//  HomeViewModel.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/30/24.
//

import Foundation
import Firebase

class HomeViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    init() {
        Task { try await fetchPosts() }
    }
    
    func fetchPosts() async throws {
        let snapshot = try await Firestore.firestore().collection("posts").getDocuments()
        self.posts = try snapshot.documents.compactMap({try $0.data(as: Post.self)})
    }
}
