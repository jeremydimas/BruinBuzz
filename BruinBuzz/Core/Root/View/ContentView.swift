//
//  ContentView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/19/24.
//

//import SwiftUI
//
//struct ContentView: View {
//    @StateObject var viewModel = ContentViewModel()
//    @StateObject var registrationViewModel = RegistrationViewModel()
//    let twitterBlue = Color(UIColor(red: 0.016, green: 0.25, blue: 0.47, alpha: 1))
//    
//    var body: some View {
//        
//        
//        Group {
//            // xcode suggested $
//            if viewModel.userSession == nil {
//                LoginView()
//                    .environmentObject(registrationViewModel)
//            } else if let currentUser = viewModel.currentUser {
//                MainTabView(user: currentUser)
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
