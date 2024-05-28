//
//  UploadPostViewModel.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/17/24.
//

import Foundation
import PhotosUI
import SwiftUI
import Firebase

@MainActor
class UploadPostViewModel: ObservableObject {
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    @Published var postImage: Image?
    private var uiImage: UIImage?
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else {return}
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else {return}
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }
    
    func uploadPost(
        title: String,
        caption: String,
        organizer: String,
        organization: String,
        location: String,
        currentTime: String,
        pastTime: String,
        link1: String,
        link2: String
//        link3: String,

    ) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let uiImage = uiImage else { return }
        
        let postRef = Firestore.firestore().collection("posts").document()
        guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else { return }
        let post = Post(
            id: postRef.documentID,
            ownerUid: uid,
            imageUrl: imageUrl,
            caption: caption,
            rsvp: 0,
            timestamp: Timestamp(),
            title: title,
            location: location,
            organizer: organizer,
            organization: organization,
            currentTime: currentTime,
            pastTime: pastTime,
            link1: link1,
            link2: link2
//            link3: link3,
            
        )
        guard let encodedPost = try? Firestore.Encoder().encode(post) else { return }
         
        try await postRef.setData(encodedPost)
    }
}
