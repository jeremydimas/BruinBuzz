//
//  HomeCellViewModel.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 5/8/24.
//

import Foundation

class HomeCellViewModel: ObservableObject {
    
    // like implementation
    @Published var post: Post
    private let service = PostService()
    
    init(post: Post) {
        self.post = post
        checkIfUserRsvpPost()
    }
    
    func likePost() {
        service.likePost(post) {
            self.post.didRsvp = true
        }
    }
    
    func unRsvpPost() {
        service.unRsvpPost(post) {
            self.post.didRsvp = false
        }
    }
    
    func checkIfUserRsvpPost() {
        service.checkIfUserRsvpPost(post) { didRsvp in
            if didRsvp {
                self.post.didRsvp = true
            }
        }
    }
    // ends here
}
