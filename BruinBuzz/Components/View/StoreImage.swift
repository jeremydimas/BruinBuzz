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
//    let twitterBlue = Color(UIColor(red: 0.016, green: 0.25, blue: 0.47, alpha: 1))

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    // Size Classes for Different Screen Displays
    enum DeviceType {
        case iPhone8Plus
        case iPadPro129
        case other
        
        static func current() -> DeviceType {
            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height
            
            if (screenWidth == 414 && screenHeight == 736) || (screenWidth == 736 && screenHeight == 414) {
                return .iPhone8Plus
            } else if (screenWidth == 1024 && screenHeight == 1366) || (screenWidth == 1366 && screenHeight == 1024) {
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
            return 400
        case .iPadPro129:
            return 840
        case .other:
            switch (horizontalSizeClass, verticalSizeClass) {
            // iPhone
            case (.compact, .regular):
                return 535
            // iPad
            case (.regular, .regular):
                return 840
            default:
                return 535
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
    
    let post: Post
    
    var body: some View {
        KFImage(URL(string: post.imageUrl))
            .resizable()
//            .frame(width: 360, height: 535)
            .frame(maxWidth: maxWidthForImage(), maxHeight: maxHeightForImage())
            .aspectRatio(contentMode: .fill)
            .overlay(
                OverlayView(post)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                    
                    RadialGradient(gradient: Gradient(colors: [ .white]), center: .center, startRadius: 500, endRadius: -900)
                        .ignoresSafeArea()
                    
                    ScrollView{
                        VStack{
                            
                            HStack {
                                KFImage(URL(string: post.imageUrl))
                                    .resizable()
    //                                .frame(width: 350, height: 350)
                                    .frame(width: maxWidthForBSImage(), height: maxHeightForBSImage())
                                    .clipShape(CurvedShape())
                                    .overlay(
                                        OverlayView(post)
    //                                        .frame(width: 350, height: 350)
                                            .frame(width: .infinity, height: .infinity)
                                            .clipShape(.rect(cornerRadius: 15))
                                    )
                                    .padding(.bottom, 15)
                                    .padding(.top,40)
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
                            .foregroundColor(.black)

                            
                            HStack {
                                Text("Description: ")
                                    .fontWeight(.bold) +
                                Text(post.caption)

                                Spacer()
                            }
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                            .padding(.bottom, 10)
                            .foregroundColor(.black)

                            
                            HStack {
                                Text("Start Date: ")
                                    .fontWeight(.bold) +
                                Text("\(post.startMM)/\(post.startDD)/\(post.startYYYY)") +
                                Text(" - ")
                                    .fontWeight(.bold) +
                                Text(post.starttime)
                                    .fontWeight(.regular)
                                Spacer()
                            }
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                            .padding(.bottom, 10)
                            .foregroundColor(.black)

                            
                            HStack {
                                Text("End Date: ")
                                    .fontWeight(.bold) +
                                Text("\(post.endMM)/\(post.endDD)/\(post.endYYYY)") +
                                Text(" - ")
                                    .fontWeight(.bold) +
                                Text(post.endtime)
                                    .fontWeight(.regular)
                                Spacer()
                            }
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                            .padding(.bottom, 10)
                            .foregroundColor(.black)

                            
                            VStack {
                                HStack {
                                    Text("Location:")
                                        .fontWeight(.bold)
                                    Text(post.location)
                                    Spacer()
                                }
                                .padding(.leading, 40)
                                .foregroundColor(.black)


    //                            MapView()
    //                                .frame(width: 350, height: 200)
    //                                .clipShape(CurvedShape())
    //                                .padding(.top, -1)
                            }
                            .presentationDragIndicator(.visible)
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
