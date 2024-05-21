//
//  AddEmailView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/24/24.
//

import SwiftUI

struct AddEmailView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    let twitterBlue = Color(UIColor(red: 0.494, green: 0.752, blue: 0.898, alpha: 1))
    let navy = Color(UIColor(red: 0.1, green: 0.25, blue: 0.4, alpha: 1))

    
    var body: some View {
        
        ZStack {
            RadialGradient(gradient: Gradient(colors: [ .white]), center: .center, startRadius: 500, endRadius: -900)
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                Text("Add Your Email")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.top)
                    .foregroundColor(.black)
                
                Text("You will use this email to sign into your account.")
                    .font(.subheadline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)
                
                ZStack(alignment: .leading) {
                    if viewModel.email.isEmpty {
                        Text("Email")
                            .foregroundColor(Color(.lightGray)) // Set the color of the placeholder text
                            .autocapitalization(.none)

                    }
                    TextField("", text: $viewModel.email)
                        .foregroundStyle(Color(.black))
                        .accentColor(.black)
                        .autocapitalization(.none)

                }
                .modifier(TextFieldModifier())

                NavigationLink {
                    CreateUsernameView()
                } label: {
                    Text("Next")
                        .foregroundColor(.white)
                        .frame(width:300, height:50)
                        .background(.black)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
        }
    }
}

struct AddEmailView_Previews: PreviewProvider {
    static var previews: some View {
        AddEmailView()
    }
}
