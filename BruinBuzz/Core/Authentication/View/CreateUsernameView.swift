//
//  CreateUsernameView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/24/24.
//

import SwiftUI

struct CreateUsernameView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        ZStack {
            Image("LoginBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
                Text("Create Username")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.top)
                    .foregroundColor(.white)
                
                Text("Pick a usename for your account.")
                    .font(.subheadline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)
                
                TextField("", text: $viewModel.username)
                    .autocapitalization(.none)
                    .font(.subheadline)
                    .modifier(TextFieldModifier())
                    .foregroundColor(.black) // Set the color of the entered text
                    .accentColor(.black) // Set the color of the cursor and selection
                    .colorScheme(.dark) // Ensure that the dark mode color scheme is used
                    .overlay(
                        Group {
                            if viewModel.username.isEmpty {
                                Text("Username")
                                    .foregroundColor(Color(.lightGray)) // Set the color of the placeholder text
                                    .padding(.leading, -138)
                            }
                        }
                    )
                
                NavigationLink {
                    CreatePasswordView()
                } label: {
                    Text("Next")
                        .foregroundColor(.white)
                        .frame(width:300, height:50)
                        .background(Color(.systemBlue))
                        .cornerRadius(10)
                }
                
                Spacer()
            }
        }
    }
}

struct CreateUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUsernameView()
    }
}

