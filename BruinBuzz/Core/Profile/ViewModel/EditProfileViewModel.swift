//
//  EditProfileViewModel.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/28/24.
//

import PhotosUI
import Firebase
import SwiftUI
import Combine

@MainActor
class EditProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    @Published var profileImage: Image?
    @Published var fullname: String = ""
    @Published var bio: String = ""
    
    //  my changes
    @Published var profileImageUrl: String?


    private var uiImage: UIImage?
    
    
    private var initialFullname: String
    private var initialBio: String
    
//    init(user: User) {
//        self.user = user
//        
//        if let fullname = user.fullname {
//            self.fullname = fullname
//            print(self.fullname)
//        }
//        
//        if let bio = user.bio {
//            self.bio = bio
//        }
//    }
    
    init(user: User) {
        self.user = user
        
        self.initialFullname = user.fullname ?? ""
        
        self.initialBio = user.bio ?? ""
        
        self.fullname = initialFullname
        self.bio = initialBio

    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else {return}
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else {return}
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
        print("Image selected - load image function")
    }
    
    func updateUserData() async throws {
        print("update data is refreshing...")
        var data = [String: Any]()
        
        if let uiImage = uiImage {
            print("Photo is heading to Firebase")
            // generates an image url
            let imageUrl = try? await ImageUploader.uploadImage(image: uiImage)
            data["profileImageUrl"] = imageUrl
            
            // changes
            profileImageUrl = imageUrl
            print("Photo has updated")
            
        } else {
            data["profileImageUrl"] = user.profileImageUrl
            profileImageUrl = user.profileImageUrl
            print("Image preserved?")
        }
        
        
        // update name if changed
        if !fullname.isEmpty && user.fullname != fullname {
            data["fullname"] = fullname
        }
        
        // update bio if changed
        if !bio.isEmpty && user.bio != bio {
            data["bio"] = bio
        }
        
        if !data.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
            
            // more changes
            user.profileImageUrl = profileImageUrl
        }
    }
    
    func resetImageSelection() {
        selectedImage = nil
        profileImage = nil
        uiImage = nil
        print("Image selection reset")
    }
    
    func resetChanges() {
        resetImageSelection()
        fullname = initialFullname
        bio = initialBio
        print("Changes have been reset")
    }
}
