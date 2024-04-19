//
//  UserStatView.swift
//  BruinBuzz
//
//  Created by Jeremy Dimas on 4/18/24.
//

import SwiftUI

struct UserStatView: View {
    
    let value: Int
    let title: String
    
    
    var body: some View {
        VStack{
            Text("\(value)")
                .font(.subheadline)
                .fontWeight(.semibold)
            
            Text("\(title)")
                .font(.footnote)
        }
        .frame(width: 100)
    }
}

#Preview {
    UserStatView(value: 0, title: "Events")
}
