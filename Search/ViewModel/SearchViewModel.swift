//
//  SearchViewModel.swift
//  BruinBuzz
//
//  Created by Jeremy Dimas on 5/1/24.
//

import Foundation

class SearchViewModel: ObservableObject{
    @Published var users = [User]()
    
    
    init()
    {
        Task {
            try await fetchAllUsers()
        }
    }
    @MainActor
    func fetchAllUsers() async throws
    {
        self.users = try await UserService.fetchAllUsers()
    }
}
