//
//  CompleteSignUpView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/25/24.
//

import SwiftUI

struct CompleteSignUpView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    @Environment(\.colorScheme) var colorScheme
    let twitterBlue = Color(UIColor(red: 0.494, green: 0.752, blue: 0.898, alpha: 1))
    let navy = Color(UIColor(red: 0.1, green: 0.25, blue: 0.4, alpha: 1))

    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? .black : .white)
                .ignoresSafeArea()
            VStack(spacing: 12) {
                Text("Welcome to BruinBuzz!")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.top)
                    .foregroundColor(.primary)
                
                Text("Click below to complete registration.")
                    .font(.footnote)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)
                
                Button {
                    Task { try await viewModel.createUser() }
                } label: {
                    Text("Complete Sign Up")
                        .font(.subheadline)
                        .foregroundColor(Color("WB"))
                        .frame(width:300, height:50)
                        .background(Color("BW"))
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding(.top, 60)

        }
    }
}

struct CompleteSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteSignUpView()
    }
}

