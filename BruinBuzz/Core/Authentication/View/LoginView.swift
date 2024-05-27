//
//  LoginView.swift
//  BruinBuzz
//
//  Created by Jeremy Dimas on 4/18/24.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var isLoading = false
    let twitterBlue = Color(UIColor(red: 0.494, green: 0.752, blue: 0.898, alpha: 1))
    let navy = Color(UIColor(red: 0.1, green: 0.25, blue: 0.4, alpha: 1))
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color(colorScheme == .dark ? .black : .white)
                    .ignoresSafeArea()
                VStack {
                    
                    Text("Login")
                        .foregroundColor(.primary)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .padding(.top)
                    
                    ZStack(alignment: .leading) {
                        if viewModel.email.isEmpty {
                            Text("Email")
                                .foregroundColor(Color(.lightGray)) // Set the color of the placeholder text
                                .autocapitalization(.none)

                        }
                        TextField("", text: $viewModel.email)
                            .foregroundColor(.primary)
                            .accentColor(.black)
                            .autocapitalization(.none)
                    }
                    .modifier(TextFieldModifier())

                    ZStack(alignment: .leading) {
                        if viewModel.password.isEmpty {
                            Text("Password")
                                .foregroundColor(Color(.lightGray)) // Set the color of the placeholder text
                        }
                        SecureField("", text: $viewModel.password)
                            .foregroundColor(.primary)
                            .accentColor(.black)
                    }
                    .modifier(TextFieldModifier())
                    
                    Button {
                        Task { try await viewModel.signIn() }
                    } label: {
                        Text("Login")
                            .foregroundColor(Color("WB"))
                            .frame(width:300, height:50)
                            .background(Color("BW"))
                            .cornerRadius(10)
                    }
                    
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.primary)
                            .font(.subheadline)
                        
                        NavigationLink {
                            AddEmailView()
                        } label: {
                            Text("Sign Up")
                                .foregroundColor(.primary)
                                .font(.subheadline)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                    }
                    .padding()
                    
//                    HStack {
//                        Rectangle()
//                            .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
//                        
//                        Text("OR")
//                            .font(.footnote)
//                            .fontWeight(.semibold)
//                        
//                        Rectangle()
//                            .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
//                    }
//                    .foregroundColor(.white)

                    Spacer()
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
