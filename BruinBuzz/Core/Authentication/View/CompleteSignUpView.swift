//
//  CompleteSignUpView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/25/24.
//

import SwiftUI

struct CompleteSignUpView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    let twitterBlue = Color(UIColor(red: 0.494, green: 0.752, blue: 0.898, alpha: 1))
    let navy = Color(UIColor(red: 0.1, green: 0.25, blue: 0.4, alpha: 1))

    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.white]), center: .center, startRadius: 500, endRadius: -900)
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                
                
                Text("Welcome to BruinBuzz!")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.top)
                    .foregroundColor(.black)
                
                Text("Click below to complete registration.")
                    .font(.footnote)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)
                
                Button {
                    Task { try await viewModel.createUser() }
                } label: {
                    Text("Complete Sign Up")
                        .font(.subheadline)
                        .foregroundStyle(Color(.white))
                        .frame(width:300, height:50)
                        .background(.black)
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

