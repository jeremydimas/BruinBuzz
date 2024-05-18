//
//  LoginView.swift
//  BruinBuzz
//
//  Created by Jeremy Dimas on 4/18/24.
//

import SwiftUI

struct LoginView: View {
    
    let twitterBlue = Color(UIColor(red: 0.494, green: 0.752, blue: 0.898, alpha: 1))
    let navy = Color(UIColor(red: 0.1, green: 0.25, blue: 0.4, alpha: 1))


    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack{
            
            ZStack {
                RadialGradient(gradient: Gradient(colors: [twitterBlue, .white]), center: .center, startRadius: 500, endRadius: -900)
                    .ignoresSafeArea()
                

                VStack {
                    
                    Text("Login")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    ZStack(alignment: .leading) {
                        if viewModel.email.isEmpty {
                            Text("Email")
                                .foregroundColor(Color(.lightGray)) // Set the color of the placeholder text
                        }
                        TextField("", text: $viewModel.email)
                            .foregroundStyle(Color(.black))
                            .accentColor(.black)
                    }
                    .modifier(TextFieldModifier())

                    ZStack(alignment: .leading) {
                        if viewModel.password.isEmpty {
                            Text("Password")
                                .foregroundColor(Color(.lightGray)) // Set the color of the placeholder text
                        }
                        SecureField("", text: $viewModel.password)
                            .foregroundStyle(Color(.black))
                            .accentColor(.black)
                    }
                    .modifier(TextFieldModifier())
                    
                    Button {
                        Task { try await viewModel.signIn() }
                    } label: {
                        Text("Login")
                            .foregroundColor(.white)
                            .frame(width:300, height:50)
                            .background(navy)
                            .cornerRadius(10)
                    }
                    
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.white)
                            .font(.subheadline)
                        
                        NavigationLink {
                            AddEmailView()
                        } label: {
                            Text("Sign Up")
                                .foregroundColor(navy)
                                .font(.subheadline)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                    }
                    .padding()
                    
                    HStack {
                        Rectangle()
                            .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                        
                        Text("OR")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Rectangle()
                            .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                    }
                    .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.top, 40)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
