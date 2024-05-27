//
//  RequestUser.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 5/20/24.
//

import SwiftUI

struct RequestUser: View {
    let twitterBlue = Color(UIColor(red: 0.494, green: 0.752, blue: 0.898, alpha: 1))
    let navy = Color(UIColor(red: 0.1, green: 0.25, blue: 0.4, alpha: 1))
    @StateObject var registrationViewModel = RegistrationViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(colorScheme == .dark ? .black : .white)
                    .ignoresSafeArea()
                VStack(spacing: 12) {
                    Text("You must have an account to use this feature.")
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.top)
                        .padding(.leading, 32)
                        .padding(.trailing, 32)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    
                    Text("Click below to login or sign-up")
                        .font(.subheadline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 8)
                    
                    NavigationLink {
                        LoginView()
                            .environmentObject(registrationViewModel)

                    } label: {
                        Text("Next")
                            .foregroundColor(Color("WB"))
                            .frame(width:300, height:50)
                            .background(Color("BW"))
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                }
                .padding(.top, 70)

            }
            

        }
    }
}

struct RequestUser_Previews: PreviewProvider {
    static var previews: some View {
        RequestUser()
    }
}
