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
    
    let twitterBlue = Color(UIColor(red: 0.016, green: 0.25, blue: 0.47, alpha: 1))

    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {

        ZStack {
            RadialGradient(gradient: Gradient(colors: [twitterBlue, .white]), center: .center, startRadius: 500, endRadius: -900)
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
                
                // edit profile pic
                
                PhotosPicker(selection: $viewModel.selectedImage) {
                    VStack {
                        if let image = viewModel.profileImage {
                            image
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 80, height: 80)
                        } else {
                            CircularProfileImageView(user: viewModel.user, size: .large)
                        }
                        
                        Text("Edit profile picture")
                            .font(.footnote)
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
                        
                        EditProfileRowView(
                            title: "Bio",
                            placeholder: "Enter your bio..",
                            text: $viewModel.bio)
                        .padding(.bottom, 10)
                        
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
//                .padding(.leading, 8)
//                .frame(width: 100, alignment: .leading)
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
        EditProfileView(user: User.MOCK_USERS[0])
    }
}
