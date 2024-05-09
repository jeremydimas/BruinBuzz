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
            .frame(width: 360, height: 535)
            .aspectRatio(contentMode: .fill)
            .overlay(
                OverlayView(post)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipShape(.rect(cornerRadius: 15))
            )
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
                        .overlay(
                            OverlayView(post)
                                .frame(width: 350, height: 350)
                                .clipShape(.rect(cornerRadius: 15))
                        )
                        .padding(.bottom, 15)
                }
                .edgesIgnoringSafeArea(.all)

                HStack {
                    Text("Organizer:")
                        .fontWeight(.bold)
                    Text(post.organizer)
                    Spacer()
                }
                .padding(.leading, 40)
                .padding(.bottom, 10)
                
                HStack {
                    Text("Start Date:")
                        .fontWeight(.bold)
                    Text("\(post.startMM)/\(post.startDD)/\(post.startYYYY)")
                    Spacer()
                    Text("Start Time:")
                        .fontWeight(.bold)
                    Text(post.starttime)
                }
                .padding(.leading, 40)
                .padding(.trailing, 40)
                .padding(.bottom, 10)
                
                HStack {
                    Text("End Date:")
                        .fontWeight(.bold)
                    Text("\(post.endMM)/\(post.endDD)/\(post.endYYYY)")
                    Spacer()
                    Text("End Time:")
                        .fontWeight(.bold)
                    Text(post.endtime)
                }
                .padding(.leading, 40)
                .padding(.trailing, 40)
                .padding(.bottom, 10)
                
                HStack {
                    Text("Description:")
                        .fontWeight(.bold)
                    Text(post.caption)
                    Spacer()
                }
                .padding(.leading, 40)
                .padding(.bottom, 20)

                VStack {
                    HStack {
                        Text("Location:")
                            .fontWeight(.bold)
                        Text(post.location)
                        Spacer()
                    }
                    .padding(.leading, 40)
                    MapView()
                        .frame(width: 350, height: 200)
                        .clipShape(CurvedShape())
                        .padding(.top, -1)
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
