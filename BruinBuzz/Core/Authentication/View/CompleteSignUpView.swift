//
//  CompleteSignUpView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/25/24.
//

import SwiftUI

struct CompleteSignUpView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        ZStack {
            Image("LoginBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
                
                Spacer()
                
                Text("Welcome to BruinBuzz!")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.top)
                    .foregroundColor(.white)
                
                Text("Click below to complete registration.")
                    .font(.footnote)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)
                
                Button {
                    Task { try await viewModel.createUser() }
                } label: {
                    Text("Complete Sign Up")
                        .font(.subheadline)
                        .foregroundStyle(Color(.white))
                        .frame(width:300, height:50)
                        .background(Color(.systemBlue))
                        .cornerRadius(10)
                }
                
                Spacer()
            }
        }
    }
}

struct CompleteSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteSignUpView()
    }
}

