//
//  LoginViewModel.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/23/24.
//

import Foundation
import FirebaseAuth
import _AuthenticationServices_SwiftUI
import CryptoKit

import AuthenticationServices

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    private var currentNonce: String?
    
    func signIn() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
    
}


