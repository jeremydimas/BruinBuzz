//
//  LoginView.swift
//  BruinBuzz
//
//  Created by Jeremy Dimas on 4/18/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack {
                Image("LoginBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack{
                        Text("Login")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .bold()
                            .padding()
                        TextField("Email", text: $viewModel.email)
                            .autocapitalization(.none)
                            .modifier(TextFieldModifier())
                        SecureField("Password", text: $viewModel.password)
                            .autocapitalization(.none)
                            .modifier(TextFieldModifier())
                    }
                    
                    Button {
                        Task { try await viewModel.signIn() }
                    } label: {
                        Text("Login")
                            .foregroundColor(.white)
                            .frame(width:300, height:50)
                            .background(Color(.systemBlue))
                            .cornerRadius(10)
                    }
                    
                    NavigationLink {
                        AddEmailView()
                    } label: {
                        HStack(spacing: 3) {
                            Text("Don't have an account?")
                                .foregroundColor(.white)
                                .font(.subheadline)
                            Text("Sign Up")
                                .foregroundColor(.blue)
                                .font(.subheadline)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
