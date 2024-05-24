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
    init(viewModel: EditProfileViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [ .white]), center: .center, startRadius: 500, endRadius: -900)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    
                    Spacer()
                    
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.black))
                    Spacer()

                    Button {
                        Task {
                            try await viewModel.updateUserData()
                            dismiss()
                        }
                    } label: {
                        Text("Done")
                            .font(.subheadline)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                }
                .padding(.horizontal)
                
                Divider()
                                
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
                    }
                }
                .padding(.vertical, 8)
                
                // edit profile info

                VStack
                {
                    VStack (alignment: .leading)
                    {
                        EditProfileRowView(
                            title: "Name",
                            placeholder: "Enter your name..",
                            text: $viewModel.fullname)
                        .padding(.top, 10)
                        .foregroundStyle(Color(.black))
                        
                        EditProfileRowView(
                            title: "Bio",
                            placeholder: "Enter your bio..",
                            text: $viewModel.bio)
                        .padding(.bottom, 10)
                        .foregroundStyle(Color(.black))
                        
                    }
                    .padding(.horizontal, 20) // Add horizontal padding to keep elements away from the border line
                    .padding(.bottom,15)
                    
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 1) // Add border line
                            
                    )
                    .padding() // Add padding to the outer VStack to ensure border visibility and spacing
                    .cornerRadius(20)
                    .frame(width: 350)
                }
                
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
        HStack {
            Text(title)
                .font(.title2)
                .bold()
                .padding(.top, 10)
            
        }
        .font(.subheadline)
        .frame(height: 36)
        VStack {
            TextField(placeholder, text: $text)
                .autocapitalization(.none)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .frame(width: 325, height: 50)
            Divider()
        }
        
    }
    
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
//        EditProfileView(user: User.MOCK_USERS[0])
        EditProfileView(viewModel: EditProfileViewModel(user: User.MOCK_USERS[0]))
    }
}
