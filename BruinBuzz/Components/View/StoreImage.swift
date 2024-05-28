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
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.colorScheme) var colorScheme
    
    let post: Post
    
    // Size Classes for Different Screen Displays
    enum DeviceType {
        case iPhone8Plus
        case iPadPro129
        case other
        
        static func current() -> DeviceType {
            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height
            
            if (screenWidth == 414 && screenHeight == 414) || (screenWidth == 736 && screenHeight == 736) {
                return .iPhone8Plus
            } else if (screenWidth == 1024 && screenHeight == 1024) || (screenWidth == 1366 && screenHeight == 1366) {
                return .iPadPro129
            } else {
                return .other
            }
        }
    }
    
    func maxWidthForImage() -> CGFloat {
        let deviceType = DeviceType.current()
        
        switch deviceType {
        case .iPhone8Plus:
            return 290
        case .iPadPro129:
            return 950
        case .other:
            switch (horizontalSizeClass, verticalSizeClass) {
            // iPhone
            case (.compact, .regular):
                return 372
            // iPad
            case (.regular, .regular):
                return 740
            default:
                return 360
            }
        }
    }

    func maxHeightForImage() -> CGFloat {
        let deviceType = DeviceType.current()
        
        switch deviceType {
        case .iPhone8Plus:
            return 290
        case .iPadPro129:
            return 950
        case .other:
            switch (horizontalSizeClass, verticalSizeClass) {
            // iPhone
            case (.compact, .regular):
                return 372
            // iPad
            case (.regular, .regular):
                return 740
            default:
                return 360
            }
        }
    }

    func horizontalPaddingForSizeClass() -> EdgeInsets {
        let deviceType = DeviceType.current()
        
        switch deviceType {
        case .iPhone8Plus:
            return EdgeInsets(top: 1, leading: 60, bottom: 0, trailing: 60)
        case .iPadPro129:
            return EdgeInsets(top: 1, leading: 35, bottom: 0, trailing: 35)
        case .other:
            switch (horizontalSizeClass, verticalSizeClass) {
            // iPhone
            case (.compact, .regular):
                return EdgeInsets(top: 1, leading: 28, bottom: 0, trailing: 28)
            // iPad
            case (.regular, .regular):
                return EdgeInsets(top: 1, leading: 45, bottom: 0, trailing: 45)
            default:
                return EdgeInsets(top: 1, leading: 37, bottom: 0, trailing: 37)
            }
        }
    }
    
    // Height and Width Sizing for the Bottom Sheet
    func maxWidthForBSImage() -> CGFloat {
        let deviceType = DeviceType.current()
        
        switch deviceType {
        case .iPhone8Plus:
            return 330
        case .iPadPro129:
            return 625
        case .other:
            switch (horizontalSizeClass, verticalSizeClass) {
            // iPhone
            case (.compact, .regular):
                return 350
            // iPad
            case (.regular, .regular):
                return 625
            default:
                return 350
            }
        }
    }

    func maxHeightForBSImage() -> CGFloat {
        let deviceType = DeviceType.current()
        
        switch deviceType {
        case .iPhone8Plus:
            return 330
        case .iPadPro129:
            return 625
        case .other:
            switch (horizontalSizeClass, verticalSizeClass) {
            // iPhone
            case (.compact, .regular):
                return 350
            // iPad
            case (.regular, .regular):
                return 625
            default:
                return 350
            }
        }
    }

    func horizontalPaddingForBSSizeClass() -> EdgeInsets {
        let deviceType = DeviceType.current()
        
        switch deviceType {
        case .iPhone8Plus:
            return EdgeInsets(top: 1, leading: 60, bottom: 0, trailing: 60)
        case .iPadPro129:
            return EdgeInsets(top: 1, leading: 35, bottom: 0, trailing: 35)
        case .other:
            switch (horizontalSizeClass, verticalSizeClass) {
            // iPhone
            case (.compact, .regular):
                return EdgeInsets(top: 1, leading: 28, bottom: 0, trailing: 28)
            // iPad
            case (.regular, .regular):
                return EdgeInsets(top: 1, leading: 45, bottom: 0, trailing: 45)
            default:
                return EdgeInsets(top: 1, leading: 37, bottom: 0, trailing: 37)
            }
        }
    }
    
    var body: some View {
        KFImage(URL(string: post.imageUrl))
            .resizable()
            .frame(maxWidth: maxWidthForImage(), maxHeight: maxHeightForImage())
            .aspectRatio(contentMode: .fill)
            .overlay(
                OverlayView(post)
                    .frame(maxWidth: maxWidthForImage(),
                                           maxHeight: maxHeightForImage())
                    .clipShape(.rect(cornerRadius: 15))
            )
            .onTapGesture {
                isImageTapped.toggle()
                showingBottomSheet.toggle()
            }
            .sheet(isPresented: $showingBottomSheet) {
                ZStack {
                    Color(colorScheme == .dark ? .black : .white)
                        .ignoresSafeArea()
                    ScrollView{
                        VStack{
                            
                            HStack {
                                KFImage(URL(string: post.imageUrl))
                                    .resizable()
                                    .frame(width: maxWidthForBSImage(), height: maxHeightForBSImage())
                                    .clipShape(CurvedShape())
                                    .overlay(
                                        OverlayView(post)
                                            .frame(width: .infinity, height: .infinity)
                                            .clipShape(.rect(cornerRadius: 15))
                                    )
                                    .padding(.bottom, 15)
                                    .padding(.top,40)
                            }
                            .edgesIgnoringSafeArea(.all)
                            
                            Divider()
                                .frame(width:350)
                                .padding(.top,15)
                            HStack{
                                Text("Event Info")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            .padding(.leading, 40)
                            .padding(.top,10)
                            .padding(.bottom, 10)
                            .foregroundColor(.primary)
                            
                            VStack{
                                HStack(alignment: .top) {
                                    Image(systemName: "person.fill")
                                        .foregroundColor(.primary)
                                    Text(post.organizer)
                                        .bold()
                                        .foregroundColor(.primary) +
                                    Text(": ")
                                        .foregroundColor(.primary) +
//                                        Spacer()
                                    Text(post.caption)
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                }
                                .padding(.leading, 40)
                                .padding(.trailing, 40)
                                .padding(.top, 5)
                                .padding(.bottom, 10)
                                .foregroundColor(.primary)

                            }
                            
                            VStack{
                                HStack(alignment: .top) {
                                    Image(systemName: "location.fill")
                                        .foregroundColor(.primary)
                                    Text(post.location)
//                                        .bold()
                                        .foregroundColor(.primary)
                                    Spacer()
                                }
                                .padding(.leading, 40)
                                .padding(.trailing, 40)
                                .padding(.top, 5)
                                .padding(.bottom, 10)
                                .foregroundColor(.primary)

                            }
                            
                            VStack{
                                HStack(alignment: .top) {
                                    Image(systemName: "calendar")
                                        .foregroundColor(.primary)
                                    Text("\(post.currentTime ?? "No date")")
                                        .foregroundColor(.primary) +
                                    Text(" - \(post.pastTime ?? "No date")")
                                        .foregroundColor(.primary)
                                    Spacer()
                                }
                                .padding(.leading, 40)
                                .padding(.trailing, 40)
                                .padding(.top, 5)
                                .padding(.bottom, 10)
                                .foregroundColor(.primary)

                            }
                            
                            Divider()
                                .frame(width:350)
                                .padding(.top,15)
                            HStack{
                                Text("Attachments")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            .padding(.leading, 40)
                            .padding(.top,10)
                            .padding(.bottom, 10)
                            .foregroundColor(.primary)
                            
                            // Links
                            
                            VStack {
                                HStack(alignment: .top) {
                                    Image(systemName: "link")
                                        .foregroundColor(.primary)
                                    if let link1 = post.link1, !link1.isEmpty, let url = URL(string: link1.hasPrefix("http") ? link1 : "https://\(link1)") {
                                        Link(link1, destination: url)
                                            .foregroundColor(.blue)
                                    } else {
                                        Text("No link provided")
                                    }
                                    Spacer()
                                }
                                .padding(.leading, 40)
                                .padding(.trailing, 40)
                                .padding(.top, 5)
                                .padding(.bottom, 10)
                                .foregroundColor(.primary)
                            }

                            
                            VStack {
                                HStack(alignment: .top) {
                                    Image(systemName: "link")
                                        .foregroundColor(.primary)
                                    if let link2 = post.link2, !link2.isEmpty, let url = URL(string: link2.hasPrefix("http") ? link2 : "https://\(link2)") {
                                        Link(link2, destination: url)
                                            .foregroundColor(.blue)
                                    } else {
                                        Text("No link provided")
                                    }
                                    Spacer()
                                }
                                .padding(.leading, 40)
                                .padding(.trailing, 40)
                                .padding(.top, 5)
                                .padding(.bottom, 10)
                                .foregroundColor(.primary)
                            }
                 
//                                MapView()
//                                    .frame(width: 350, height: 200)
//                                    .clipShape(CurvedShape())
//                                    .padding(.top, -1)
 
                        }
                    }
                }
                
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
