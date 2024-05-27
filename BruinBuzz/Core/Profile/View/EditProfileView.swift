//
//  EditProfileView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/28/24.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: EditProfileViewModel
    @Environment(\.colorScheme) var colorScheme
    init(viewModel: EditProfileViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? .black : .white)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button("Cancel") {
                        viewModel.resetChanges()
                        dismiss()
                    }
                    .foregroundColor(.primary)
                    
                    
                    Spacer()
                    
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    Spacer()

                    Button {
                        Task {
                            try await viewModel.updateUserData()
                            dismiss()
                        }
                    } label: {
                        Text("Done")
                            .foregroundColor(.primary)
                    }
                }
                .padding(.horizontal)
                .padding(16)
                
//                Divider()
                                
                PhotosPicker(selection: $viewModel.selectedImage) {
                    VStack {
                        // new image selected for profile image
                        if let image = viewModel.profileImage {
                            image
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 80, height: 80)
                                .onAppear {
                                    print("The new image has appeared in EditProfileView")
                                }
                        } else {
                            // when no new image has been selected CircularProfileImageView is called
                            CircularProfileImageView(imageUrl: viewModel.user.profileImageUrl, size: .large)
                                .onAppear {
                                    print("Circular profile view has been called initially in edit profile view")
                                }
                        }
                        
                        Text("Edit profile picture")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        Divider()
                            .padding(.top,15)
                    }
                }
                .padding(.vertical, 8)
                
                // edit profile info
                ZStack {
                    
                    VStack {

                        RoundedRectangle(cornerRadius: 20)
                            .fill(colorScheme == .dark ? Color(red: 0.1, green: 0.1, blue: 0.1) : Color.white)
                                    
                            .shadow(color: colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.25), radius: 10, x: 0, y: 0)
                                    .ignoresSafeArea()
                    }
                    .padding(.horizontal, 35) // Add padding to the outer VStack to ensure border visibility and spacing
                    .padding(.vertical)
                    VStack (alignment: .leading){
                        EditProfileRowView(
                            title: "Name",
                            placeholder: "Enter your name..",
                            text: $viewModel.fullname)
                        .padding(.top, 10)
                        .foregroundColor(.primary)
                        
                        EditProfileRowView(
                            title: "Bio",
                            placeholder: "Enter your bio..",
                            text: $viewModel.bio)
                        .padding(.bottom, 10)
                        .foregroundColor(.primary)
                    }
                    .padding(.horizontal, 20) // Add horizontal padding to keep elements away from the border line
                    .padding(.bottom,15)
                    
                    .padding() // Add padding to the outer VStack to ensure border visibility and spacing
                    .cornerRadius(20)

                }
                .padding(.top,90)
                .frame(height: 200)
                Spacer()
            }
        }
        
    }
}

struct EditProfileRowView: View {
    let title: String
    let placeholder: String
    
    @Binding var text: String
    
    var body: some View {
        Text(title)
            .padding(.top, 10)
            .foregroundColor(.primary)
            .font(.subheadline)
            .frame(height: 36)
        ZStack {
            if placeholder == "Enter your name.." {
                Image(systemName: "person.fill")
                    .foregroundColor(.primary)
                    .padding(.leading, -145)
            }
            else if placeholder == "Enter your bio.."{
                Image(systemName: "pencil.and.scribble")
                    .foregroundColor(.primary)
                    .padding(.leading, -145)
            }
            TextField(placeholder, text: $text)
                .autocapitalization(.none)
                .padding()
                .padding(.leading,35)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .frame(width: 325, height: 40)
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
//        EditProfileView(user: User.MOCK_USERS[0])
        EditProfileView(viewModel: EditProfileViewModel(user: User.MOCK_USERS[0]))
    }
}
