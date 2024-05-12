//
//  TextFieldModifier.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/24/24.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .padding(12)
            .frame(width:300, height:50)
            .background(Color.white.opacity(1))
//            .background(Color.gray)
            .cornerRadius(10)
    }
}
