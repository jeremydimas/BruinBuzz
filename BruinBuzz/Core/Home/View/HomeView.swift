//
//  HomeView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/27/24.
//

import SwiftUI
import Foundation

struct HomeView: View {
    
    // Fetch Feed
    @StateObject var viewModel = HomeViewModel()
    @State private var isSearching: Bool = false
        // Ends here
    
    let twitterBlue = Color(UIColor(red: 0.016, green: 0.25, blue: 0.47, alpha: 1))

    
    @State private var searchText: String = ""
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    enum DeviceType {
        case iPhone8Plus
//        case iPhone11ProMax
        case iPadPro129
        case other
        
        static func current() -> DeviceType {
            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height
            
            if (screenWidth == 414 && screenHeight == 736) || (screenWidth == 736 && screenHeight == 414) {
                return .iPhone8Plus
//            } else if (screenWidth == 414 && screenHeight == 896) || (screenWidth == 896 && screenHeight == 414) {
//                return .iPhone11ProMax
            } else if (screenWidth == 1024 && screenHeight == 1366) || (screenWidth == 1366 && screenHeight == 1024) {
                return .iPadPro129
            } else {
                return .other
            }
        }
    }
    
    func maxWidthForHVImage() -> CGFloat {
        let deviceType = DeviceType.current()
        
        switch deviceType {
        case .iPhone8Plus:
            return 290 // Adjust as needed for iPhone 8 Plus
//        case .iPhone11ProMax:
//            return 370 // Adjust as needed for iPhone 11 Pro Max
        case .iPadPro129:
            return 950 // Adjust as needed for iPad Pro 12.9-inch
        case .other:
            switch (horizontalSizeClass, verticalSizeClass) {
            case (.compact, .regular):
                return 372 // Adjust as needed for compact regular size class (e.g., iPhones in landscape)
            case (.regular, .regular):
                return 740 // Adjust as needed for regular compact size class (e.g., iPads in portrait)
            default:
                return 360 // Adjust as needed for regular regular size class (e.g., iPads in landscape)
            }
        }
    }

    func maxHeightForHVImage() -> CGFloat {
        let deviceType = DeviceType.current()
        
        switch deviceType {
        case .iPhone8Plus:
            return 400 // Adjust as needed for iPhone 8 Plus
//        case .iPhone11ProMax:
//            return 535 // Adjust as needed for iPhone 11 Pro Max
        case .iPadPro129:
            return 840 // Adjust as needed for iPad Pro 12.9-inch
        case .other:
            switch (horizontalSizeClass, verticalSizeClass) {
            case (.compact, .compact):
                return 2000 // Adjust as needed for compact compact size class (e.g., iPhones in portrait)
            case (.compact, .regular):
                return 535 // Adjust as needed for compact regular size class (e.g., iPhones in landscape)
            case (.regular, .regular):
                return 840 // Adjust as needed for regular compact size class (e.g., iPads in portrait)
            default:
                return 535 // Adjust as needed for regular regular size class (e.g., iPads in landscape)
            }
        }
    }

    func horizontalPaddingForSizeClass() -> EdgeInsets {
        let deviceType = DeviceType.current()
        
        switch deviceType {
        case .iPhone8Plus:
            return EdgeInsets(top: 1, leading: 60, bottom: 0, trailing: 60) // Adjust as needed for iPhone 8 Plus
//        case .iPhone11ProMax:
//            return EdgeInsets(top: 1, leading: 37, bottom: 0, trailing: 37) // Adjust as needed for iPhone 11 Pro Max
        case .iPadPro129:
            return EdgeInsets(top: 1, leading: 35, bottom: 0, trailing: 35) // Adjust as needed for iPad Pro 12.9-inch
        case .other:
            switch (horizontalSizeClass, verticalSizeClass) {
            case (.compact, .regular):
                return EdgeInsets(top: 1, leading: 28, bottom: 0, trailing: 28) // iPhone in landscape
            case (.regular, .regular):
                return EdgeInsets(top: 1, leading: 45, bottom: 0, trailing: 45) // iPad
            default:
                return EdgeInsets(top: 1, leading: 37, bottom: 0, trailing: 37)
            }
        }
    }
    ///
    
    
    
    

//original
    
//    func maxWidthForHVImage() -> CGFloat {
//            switch (horizontalSizeClass, verticalSizeClass) {
////            case (.compact, .compact):
////                return 300 // Adjust as needed for compact compact size class (e.g., iPhones in portrait)
//            case (.compact, .regular):
//                return 360 // Adjust as needed for compact regular size class (e.g., iPhones in landscape)
//            case (.regular, .regular):
//                    // 740
//                return 740 // Adjust as needed for regular compact size class (e.g., iPads in portrait)
//            default:
//                return 360 // Adjust as needed for regular regular size class (e.g., iPads in landscape)
//            }
//        }
//
//        func maxHeightForHVImage() -> CGFloat {
//            switch (horizontalSizeClass, verticalSizeClass) {
//            case (.compact, .compact):
//                return 2000 // Adjust as needed for compact compact size class (e.g., iPhones in portrait)
//            case (.compact, .regular):
//                return 535 // Adjust as needed for compact regular size class (e.g., iPhones in landscape)
//            case (.regular, .regular):
//                return 840 // Adjust as needed for regular compact size class (e.g., iPads in portrait)
//            default:
//                return 535 // Adjust as needed for regular regular size class (e.g., iPads in landscape)
//            }
//        }
    // original
    
//    func horizontalPaddingForSizeClass() -> EdgeInsets {
//            switch (horizontalSizeClass, verticalSizeClass) {
////            case (.compact, .compact):
////                return EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
//            //iPhone
//            case (.compact, .regular):
//                return EdgeInsets(top: 1, leading: 37, bottom: 0, trailing: 37)
//            //iPad
//            case (.regular, .regular):
//                return EdgeInsets(top: 1, leading: 45, bottom: 0, trailing: 45)
//
//            default:
//                return EdgeInsets(top: 1, leading: 37, bottom: 0, trailing: 37)
//            }
//        }
    
    //ignore
    
//    func horizontalPaddingForSizeClass() -> EdgeInsets {
//        let screenWidth = UIScreen.main.bounds.width
//        let screenHeight = UIScreen.main.bounds.height
//
//        // Check if the device is iPad Pro 12.9-inch
//        if screenWidth == 2732 && screenHeight == 2048 {
//            // Adjustments for iPad Pro 12.9-inch
//            return EdgeInsets(top: 1, leading: 60, bottom: 0, trailing: 60)
//        }
//        // Check if the device is iPhone 8 Plus
//        else if screenWidth == 414 && screenHeight == 736 {
//            // Adjustments for iPhone 8 Plus
//            return EdgeInsets(top: 1, leading: 20, bottom: 0, trailing: 20)
//        }
//        // Check for other devices
//        else {
//            // Determine padding based on size classes
//            switch (horizontalSizeClass, verticalSizeClass) {
//            case (.compact, .regular): // iPhone in landscape
//                return EdgeInsets(top: 1, leading: 37, bottom: 0, trailing: 37)
//            case (.regular, .regular): // iPad
//                return EdgeInsets(top: 1, leading: 45, bottom: 0, trailing: 45)
//            default:
//                return EdgeInsets(top: 1, leading: 37, bottom: 0, trailing: 37)
//            }
//        }
//    }
    
    // Text Padding Adjustment
    func horizontalPaddingForText() -> EdgeInsets {
        let deviceType = DeviceType.current()
        
        switch deviceType {
        case .iPhone8Plus:
            return EdgeInsets(top: 20, leading: -140, bottom: 5, trailing: 0) // Adjust as needed for iPhone 8 Plus
//        case .iPhone11ProMax:
//            return EdgeInsets(top: 1, leading: 37, bottom: 0, trailing: 37) // Adjust as needed for iPhone 11 Pro Max
        case .iPadPro129:
            return EdgeInsets(top: 20, leading: -475, bottom: 5, trailing: 0) // Adjust as needed for iPad Pro 12.9-inch
        case .other:
            switch (horizontalSizeClass, verticalSizeClass) {
            case (.compact, .regular):
                return EdgeInsets(top: 20, leading: -180, bottom: 5, trailing: 0) // iPhone in landscape
            case (.regular, .regular):
                return EdgeInsets(top: 20, leading: -365, bottom: 5, trailing: 0) // iPad
            default:
                return EdgeInsets(top: 20, leading: 37, bottom: 5, trailing: 0)
            }
        }
    }
    
    func horizontalPaddingForText2() -> EdgeInsets {
        let deviceType = DeviceType.current()
        
        switch deviceType {
        case .iPhone8Plus:
            return EdgeInsets(top: 10, leading: -140, bottom: 1, trailing: 0) // Adjust as needed for iPhone 8 Plus
//        case .iPhone11ProMax:
//            return EdgeInsets(top: 1, leading: 37, bottom: 0, trailing: 37) // Adjust as needed for iPhone 11 Pro Max
        case .iPadPro129:
            return EdgeInsets(top: 10, leading: -475, bottom: 1, trailing: 0) // Adjust as needed for iPad Pro 12.9-inch
        case .other:
            switch (horizontalSizeClass, verticalSizeClass) {
            case (.compact, .regular):
                return EdgeInsets(top: 10, leading: -180, bottom: 1, trailing: 0) // iPhone in landscape
            case (.regular, .regular):
                return EdgeInsets(top: 10, leading: -365, bottom: 1, trailing: 0) // iPad
            default:
                return EdgeInsets(top: 10, leading: 37, bottom: 1, trailing: 0)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                RadialGradient(gradient: Gradient(colors: [twitterBlue, .white]), center: .center, startRadius: 500, endRadius: -900)
                    .ignoresSafeArea()
                
                
                
                VStack {
                    // Search Bar
                    Text("BRUINBUZZ")
                        .font(Font.custom("NexaRustSans-Trial-Black2", size: 20))
                        .foregroundColor(.primary)
        //                .padding(.bottom, 5)
        //                .padding(.top, 20)
        //                .padding(.leading, -180) // Adjust this value as needed
                        .padding(horizontalPaddingForText())
                    
                    ZStack(alignment: .leading)
                    {
                        Capsule()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 40)
                            .frame(maxWidth: maxWidthForHVImage())
                            
                        
                        HStack(spacing: 12)
                        {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 10)
                            
                            TextField("Search", text: $searchText)
                                .padding(.horizontal, -10)
                                .onTapGesture
                                {
                                    isSearching = true // Set searching state to true when tapped
                                }
                        }
                        .padding(.horizontal, 10)
                    }
        //            .padding(.horizontal, 30)
                    .padding(horizontalPaddingForSizeClass())
        //            .padding(.bottom)
                    
                    Text("All Events")
                        .font(Font.custom("NexaRustSans-Trial-Black2", size: 20))
                        .foregroundColor(.primary)
        //                .padding(.top, 10)
        //                .padding(.bottom, 1)
        //                .padding(.leading, -180) // Adjust this value as needed
        ////                .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(horizontalPaddingForText2())
                    
                    ScrollView {
                        ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(viewModel.posts) { post in
                                        HomeCell(post: post)
                                            .frame(width: maxWidthForHVImage()/*, height: maxHeightForHVImage()*/) // 430
                                            .padding(horizontalPaddingForSizeClass())
                                    }
                                }
                        }
                    }
                    .refreshable {
                        do {
                            try await viewModel.fetchPosts()
                        } catch {
                            // Handle the error here, you can log it or display an alert to the user
                            print("Error fetching posts: \(error)")
                        }
                    }
                }
                Spacer()

            }
            
            
            
            
        }
        .fullScreenCover(isPresented: $isSearching)
        {
            SearchPage()
        }
    }
    
}

struct Refresh {
    var startOffset: CGFloat = 0
    var offset: CGFloat = 0
    var started: Bool
    var released: Bool
    var invalid: Bool = false
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

