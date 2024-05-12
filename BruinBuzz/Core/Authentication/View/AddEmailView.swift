//
//  AddEmailView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/24/24.
//

import SwiftUI

struct AddEmailView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        
        ZStack {
            Image("LoginBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
                Text("Add Your Email")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.top)
                    .foregroundColor(.white)
                
                Text("You will use this email to sign into your account.")
                    .font(.subheadline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)
                

                TextField("Email", text: $viewModel.email)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .modifier(TextFieldModifier())

                NavigationLink {
                    CreateUsernameView()
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

struct AddEmailView_Previews: PreviewProvider {
    static var previews: some View {
        AddEmailView()
    }
}
