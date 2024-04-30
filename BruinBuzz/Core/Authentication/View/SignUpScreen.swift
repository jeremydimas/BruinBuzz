////
////  SignUpScreen.swift
////  BruinBuzz
////
////  Created by Jeremy Dimas on 4/14/24.
////
//
//import SwiftUI
//
//struct SignUpScreen: View {
//    
//    // YAHIR'S CHANGES
//    @Environment(\.dismiss) var dismiss
//    @EnvironmentObject var viewModel: RegistrationViewModel
//    @State private var firstname = ""
//    @State private var lastname = ""
//    // removed email
////    @State private var wrongFirstName = 0
////    @State private var wrongLastName = 0
////    @State private var wrongEmail = 0
////    @State private var wrongUsername = 0
////    @State private var wrongPassword = 0
//    @State private var showingLoginScreen = false
//    
//    var body: some View {
//        NavigationView{
//            ZStack{
//                Image("LoginBackground")
//                VStack{
//                    
//                    Text("Sign Up")
//                        .foregroundColor(.white)
//                        .font(.largeTitle)
//                        .bold()
//                        .padding()
//                    TextField("First Name", text: $firstname)
//                        .padding()
//                        .frame(width:300, height:50)
//                        .background(Color.white.opacity(1))
//                        .cornerRadius(10)
////                        .border(.red,width:CGFloat(wrongFirstName))
//                    TextField("Last Name", text: $lastname)
//                        .padding()
//                        .frame(width:300, height:50)
//                        .background(Color.white.opacity(1))
//                        .cornerRadius(10)
////                        .border(.red,width:CGFloat(wrongLastName))
//                    TextField("Email", text: $viewModel.email)
//                        .padding()
//                        .frame(width:300, height:50)
//                        .background(Color.white.opacity(1))
//                        .cornerRadius(10)
////                        .border(.red,width:CGFloat(wrongEmail))
//                    TextField("Username", text: $viewModel.username)
//                        .padding()
//                        .frame(width:300, height:50)
//                        .background(Color.white.opacity(1))
//                        .cornerRadius(10)
////                        .border(.red,width:CGFloat(wrongUsername))
//                    SecureField("Password", text: $viewModel.password)
//                        .padding()
//                        .frame(width:300, height:50)
//                        .background(Color.white.opacity(1))
//                        .cornerRadius(10)
////                        .border(.red,width:CGFloat(wrongPassword))
//                    
//                    Button {
//                        Task { try await viewModel.createUser() }
//                    } label: {
//                        Text("Sign Up")
//                            .foregroundColor(.black)
//                            .frame(width:300, height:50)
//                            .background(Color.white)
//                            .cornerRadius(10)
//                    }
//                    
//                    Text("Have an account?")
//                        .foregroundColor(.white)
//                    
//                    NavigationLink(destination: LoginView()){
//                        Text("Log In")
//                    }
//                        .foregroundColor(.blue)
//                        .font(.subheadline)
//                    
//                    Button(action: {
//                        showingLoginScreen = true
//                    }) {
//                        EmptyView()
//                    }
//                    .navigationDestination(isPresented: $showingLoginScreen) {
//                        MainTabView()
//                            .navigationBarBackButtonHidden(true)
//                    }
//                }
//            }
//        }
//        .navigationBarHidden(true)
//    }
////    func authenticateUser(firstname: String, lastname: String, email: String, username: String, password: String){
////        if !firstname.isEmpty && !lastname.isEmpty && !email.isEmpty && !username.isEmpty && !password.isEmpty{
////            showingLoginScreen = true
////            wrongFirstName = 0
////            wrongLastName = 0
////            wrongEmail = 0
////            wrongUsername = 0
////            wrongPassword = 0
////        }else{
////            wrongFirstName = firstname.isEmpty ? 2 : 0
////            wrongLastName = lastname.isEmpty ? 2 : 0
////            wrongEmail = email.isEmpty ? 2 : 0
////            wrongUsername = username.isEmpty ? 2 : 0
////            wrongPassword = password.isEmpty ? 2 : 0
////        }
////    }
//}
//
//#Preview {
//    SignUpScreen()
//}