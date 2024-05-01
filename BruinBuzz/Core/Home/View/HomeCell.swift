//
//  Home.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/17/24.
//

import SwiftUI
import MapKit

struct HomeCell: View {
    
    let post: Post
    @State private var searchText: String = ""
    @State var showingBottomSheet = false
    @State private var isImageTapped = false
    
    var body: some View {
        VStack(spacing: 15) {
            
            // IMAGE FOR ONE - ASPECT
            PostView(post: post)
            
            // ENDS HERE
        }
    }
}

struct HomeCell_Previews: PreviewProvider {
    static var previews: some View {
        HomeCell(post: Post.MOCK_POSTS[0])
    }
}
