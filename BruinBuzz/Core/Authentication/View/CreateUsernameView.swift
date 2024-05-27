//
//  CreateUsernameView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/24/24.
//

import SwiftUI

struct CreateUsernameView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    @Environment(\.colorScheme) var colorScheme
    let twitterBlue = Color(UIColor(red: 0.494, green: 0.752, blue: 0.898, alpha: 1))
    let navy = Color(UIColor(red: 0.1, green: 0.25, blue: 0.4, alpha: 1))
    let uclaBlue = Color(UIColor(red: 0.3, green: 0.42, blue: 0.65, alpha: 1))

    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? .black : .white)
                .ignoresSafeArea()
            VStack(spacing: 12) {
                Text("Create Username")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.top)
                    .foregroundColor(.primary)
                
                Text("Pick a usename for your account.")
                    .font(.subheadline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)
                
                ZStack(alignment: .leading) {
                    if viewModel.username.isEmpty {
                        Text("Username")
                            .foregroundColor(Color(.lightGray)) // Set the color of the placeholder text
                            .autocapitalization(.none)

                    }
                    TextField("", text: $viewModel.username)
                        .foregroundColor(.primary)
                        .accentColor(.black)
                        .autocapitalization(.none)

                }
                .modifier(TextFieldModifier())
                
                NavigationLink {
                    CreatePasswordView()
                } label: {
                    Text("Next")
                        .foregroundColor(Color("WB"))
                        .frame(width:300, height:50)
                        .background(Color("BW"))
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

