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
    // Fetch Feed
    @MainActor
    func fetchPosts() async throws {
        self.posts = try await PostService.fetchFeedPosts()

    }
}
