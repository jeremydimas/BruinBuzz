//
//  AuthService.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/19/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    static let shared = AuthService()
    
    init() {
        Task { try await loadUserData() }
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadUserData()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(email: String, password: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            await uploadUserData(uid: result.user.uid, username: username, email: email)
        }   catch {
            print("DEBUG: Failed to register user with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func loadUserData() async throws {
        self.userSession = Auth.auth().currentUser
        guard let currentUid = userSession?.uid else { return }
        self.currentUser = try await UserService.fetchUser(withUid: currentUid)

    }
    
    func signout() {
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    
    func deleteAccount() async throws {
        do {
            try await Auth.auth().currentUser?.delete()
            deleteUserData()
            self.currentUser = nil
            self.userSession = nil
        } catch {
            print("DEBUG: Failed to delete account with error \(error.localizedDescription)")
        }
    }
    
    private func uploadUserData(uid: String, username: String, email: String) async {
        let user = User(id: uid, username: username, email: email)
        self.currentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
    
//    func deleteUserData() {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        
//        Post.MOCK_POSTS.forEach { post in
//            guard let postId = post.id else { return }
//            Firestore.firestore().collection("posts").document(postId).delete()
//        }
//        Firestore.firestore().collection("users").document(uid).delete()
//        
//    }

    func deleteUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let postsCollection = Firestore.firestore().collection("posts")
        
        // Fetch posts where ownerUid is equal to the current user's uid
        postsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching posts: \(error)")
                return
            }
            
            // Check if there are any documents returned
            guard let documents = snapshot?.documents else {
                print("No posts found for user.")
                return
            }
            
            // Delete each post
            for document in documents {
                postsCollection.document(document.documentID).delete { error in
                    if let error = error {
                        print("Error deleting post: \(error)")
                    } else {
                        print("Post successfully deleted")
                    }
                }
            }
            
            // After deleting the posts, delete the user document
            Firestore.firestore().collection("users").document(uid).delete { error in
                if let error = error {
                    print("Error deleting user: \(error)")
                } else {
                    print("User successfully deleted")
                }
            }
        }
    }

}
