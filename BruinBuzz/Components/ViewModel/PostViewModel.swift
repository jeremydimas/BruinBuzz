//
//  PostViewModel.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 5/3/24.
//

import Foundation

class PostViewModel: ObservableObject {
    private let user: User
    @Published var posts = [Post]()
    
    // rsvp implementation
    @Published var rsvpPosts = [Post]()
    private let service = PostService()
    private let userService = UserService()
    // ends here
    
    init(user: User) {
        self.user = user
        self.fetchRsvpPosts()
        Task { try await fetchUserPosts() }
    }
    
    func posts(forFilter filter: PostFilterViewModel) -> [Post] {
        switch filter {
        case .rsvp:
            return rsvpPosts
        }
    }
    
    @MainActor
    func fetchUserPosts() async throws {
        self.posts = try await PostService.fetchUserPosts(uid: user.id)
        
        for i in 0 ..< posts.count {
            print(i)
            posts[i].user = self.user
        }
    }
    
    func fetchRsvpPosts() {
        /*guard */let uid = user.id /*else { return }*/
        service.fetchRsvpPosts(forUid: uid) { posts in
            self.rsvpPosts = posts
        }
    }
}
