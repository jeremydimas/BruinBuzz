//
//  PostFilterViewModel.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 5/9/24.
//

import Foundation

enum PostFilterViewModel: Int, CaseIterable {
    case rsvp
    
    var title: String {
        switch self {
        case .rsvp: return "Upcoming Events"
        }
    }
}
