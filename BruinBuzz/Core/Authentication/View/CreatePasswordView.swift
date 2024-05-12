//
//  CreatePasswordView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/24/24.
//

import SwiftUI

struct CreatePasswordView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        ZStack {
            Image("LoginBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
                Text("Create Password")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.top)
                    .foregroundColor(.white)
                
                Text("Password must be six characters in length.")
                    .font(.subheadline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)
                
                TextField("", text: $viewModel.password)
                    .autocapitalization(.none)
                    .font(.subheadline)
                    .modifier(TextFieldModifier())
                    .foregroundColor(.black) // Set the color of the entered text
                    .accentColor(.black) // Set the color of the cursor and selection
                    .colorScheme(.dark) // Ensure that the dark mode color scheme is used
                    .overlay(
                        Group {
                            if viewModel.password.isEmpty {
                                Text("Password")
                                    .foregroundColor(Color(.lightGray)) // Set the color of the placeholder text
                                .padding(.leading, -138)
                            }
                        }
                    )
                
                NavigationLink {
                    CompleteSignUpView()
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

struct CreatePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePasswordView()
    }
}
