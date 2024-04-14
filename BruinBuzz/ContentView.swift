//
//  ContentView.swift
//  BruinBuzz
//
//  Created by Jeremy Dimas on 4/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("LoginBackground")
                VStack{
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.white.opacity(1))
                        .cornerRadius(10)
                        .border(.red,width:CGFloat(wrongUsername))
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.white.opacity(1))
                        .cornerRadius(10)
                        .border(.red,width:CGFloat(wrongPassword))
                    Button("Login"){
                        
                        authenticateUser(username: username, password: password)
                        
                    }
                    .foregroundColor(.white)
                    .frame(width:300, height:50)
                    .background(Color.black)
                    .cornerRadius(10)
                    
                    NavigationLink(destination: Text("You are logged in @\(username)"),isActive:$showingLoginScreen){
                        EmptyView()
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    func authenticateUser(username: String, password: String){
        if username.lowercased() == ""{
            wrongUsername = 0
            if password.lowercased() == ""{
                wrongPassword = 0
                showingLoginScreen = true
            }else{
                wrongPassword = 2
            }
        }else{
            wrongUsername = 2
        }
    }
}

#Preview {
    ContentView()
}
