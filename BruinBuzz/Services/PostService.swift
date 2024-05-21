//  PostService.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 5/3/24.
//

import Firebase
import FirebaseAuth

struct PostService {
    private static let postsCollection = Firestore.firestore().collection("posts")
    
    static func fetchFeedPosts() async throws -> [Post] {
        let snapshot = try await postsCollection
            .order(by: "timestamp", descending: true)
            .getDocuments()
        print("I am here")
        var posts = try snapshot.documents.compactMap({try $0.data(as: Post.self)})

        for i in 0 ..< posts.count {
            let post = posts[i]
            let ownerUid = post.ownerUid
            let postUser = try await UserService.fetchUser(withUid: ownerUid)
            posts[i].user = postUser
        }
        
        return posts
    }
    
    static func fetchUserPosts(uid: String) async throws -> [Post] {
        let snapshot = try await postsCollection
            .whereField("ownerUid", isEqualTo: uid)
            .order(by: "timestamp", descending: true)
            .getDocuments()
        return try snapshot.documents.compactMap({try $0.data(as: Post.self)})
    }
    

}

// MARK: - Likes

extension PostService {
    func likePost(_ post: Post, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let postId = post.id else { return }// this was modified differently - time 6:09.00
        
        let userRsvpRef = Firestore.firestore().collection("users").document(uid).collection("user-rsvp")
        
        Firestore.firestore().collection("posts").document(postId)
            .updateData(["rsvp": post.rsvp + 1]) { _ in
                userRsvpRef.document(postId).setData([:]) { _ in
                    completion()
                }
            }
    }
    
    func unRsvpPost(_ post: Post, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let postId = post.id else { return }// this was modified differently - time 6:09.00
        guard post.rsvp > 0 else { return }
        
        let userRsvpRef = Firestore.firestore().collection("users").document(uid).collection("user-rsvp")
        
        Firestore.firestore().collection("posts").document(postId)
            .updateData(["rsvp": post.rsvp - 1]) { _ in
                userRsvpRef.document(postId).delete { _ in
                    completion()
                }
            }
    }
    
    func checkIfUserRsvpPost(_ post: Post, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let postId = post.id else { return }// this was modified differently - time 6:09.00

        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-rsvp")
            .document(postId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }
    
    func fetchRsvpPosts(forUid uid: String, completion: @escaping([Post]) -> Void) {
        var posts = [Post]()
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-rsvp")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                documents.forEach { doc in
                    let postId = doc.documentID
                    
                    Firestore.firestore().collection("posts")
                        .document(postId)
                        .getDocument { snapshot, _ in
                            guard let post = try? snapshot?.data(as: Post.self) else { return }
                            posts.append(post)
                            
                            completion(posts)
                        }
                }
            }
    }
}
