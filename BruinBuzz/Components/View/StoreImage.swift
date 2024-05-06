//
//  StoreImage.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 5/4/24.
//

import SwiftUI
import Kingfisher
import MapKit

struct StoreImage: View {
    @State private var showingBottomSheet = false
    @State private var isImageTapped = false
    let post: Post
    
    var body: some View {
        KFImage(URL(string: post.imageUrl))
            .resizable()
            .frame(width: 360, height: 360)
            .aspectRatio(contentMode: .fill)
            .onTapGesture {
                isImageTapped.toggle()
                showingBottomSheet.toggle()
            }
            .sheet(isPresented: $showingBottomSheet) {
                HStack {
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .frame(width: 350, height: 350)
                        .clipShape(CurvedShape())
                        .padding(.bottom, 15)
                }
                .edgesIgnoringSafeArea(.all)
                Divider()
                VStack {
                    Text("Location")
                        .fontWeight(.bold)
                        .offset(x: -145, y: 15)
                    Text("Dockweiler Beach, Los Angeles")
                        .offset(x: -60, y: 15)
                    MapView()
                        .frame(width: 360, height: 200)
                        .clipShape(CurvedShape())
                        .padding()
                }
                .presentationDragIndicator(.visible)

            }
            .clipShape(.rect(cornerRadius: 15))
            .shadow(color: Color.black.opacity(0.25), radius: 8, x: 5, y: 10)
    }
}

struct StoreImage_Previews: PreviewProvider {
    static var previews: some View {
        StoreImage(post: Post.MOCK_POSTS[0])
    }
}
