//
//  HomeView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/27/24.
//

import SwiftUI
import Foundation

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var isSearching: Bool = false
    let twitterBlue = Color(UIColor(red: 0.494, green: 0.752, blue: 0.898, alpha: 1))
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.colorScheme) var colorScheme

    @State private var searchText: String = ""

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
    
    func maxWidthForHVImage() -> CGFloat {
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

    func maxHeightForHVImage() -> CGFloat {
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

    // Text Padding Adjustment
    func horizontalPaddingForText() -> EdgeInsets {
        let deviceType = DeviceType.current()
        
        switch deviceType {
        case .iPhone8Plus:
            return EdgeInsets(top: 20, leading: -140, bottom: 5, trailing: 0)
        case .iPadPro129:
            return EdgeInsets(top: 20, leading: -475, bottom: 5, trailing: 0)
        case .other:
            switch (horizontalSizeClass, verticalSizeClass) {
            // iPhone
            case (.compact, .regular):
                return EdgeInsets(top: 20, leading: -180, bottom: 5, trailing: 0)
            // iPad
            case (.regular, .regular):
                return EdgeInsets(top: 20, leading: -365, bottom: 5, trailing: 0)
            default:
                return EdgeInsets(top: 20, leading: 37, bottom: 5, trailing: 0)
            }
        }
    }
    
    func horizontalPaddingForText2() -> EdgeInsets {
        let deviceType = DeviceType.current()
        
        switch deviceType {
        case .iPhone8Plus:
            return EdgeInsets(top: 10, leading: -140, bottom: 1, trailing: 0)
        case .iPadPro129:
            return EdgeInsets(top: 10, leading: -475, bottom: 1, trailing: 0)
        case .other:
            switch (horizontalSizeClass, verticalSizeClass) {
            // iPhone
            case (.compact, .regular):
                return EdgeInsets(top: 10, leading: -180, bottom: 1, trailing: 0)
            // iPad
            case (.regular, .regular):
                return EdgeInsets(top: 10, leading: -365, bottom: 1, trailing: 0)
            default:
                return EdgeInsets(top: 10, leading: 37, bottom: 1, trailing: 0)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color(colorScheme == .dark ? .black : .white)
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        // Search Bar
                        Text("BRUINBUZZ")
                            .font(Font.custom("NexaRustSans-Trial-Black2", size: 20))
                            .foregroundColor(.primary)
                            .padding(horizontalPaddingForText())
                            .padding(.top)
                        
                        ZStack(alignment: .leading)
                        {
                            Capsule()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 40)
                                .frame(maxWidth: maxWidthForHVImage())
                                
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 10)
                                
                                ZStack(alignment: .leading) {
                                    Text("Search")
                                        .foregroundColor(Color(.lightGray)) // Set the color of the placeholder text
                                        .autocapitalization(.none)
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                        .onTapGesture
                        {
                            isSearching = true // Set searching state to true when tapped
                        }
                        .padding(horizontalPaddingForSizeClass())
                        
                        Text("All Events")
                            .font(Font.custom("NexaRustSans-Trial-Black2", size: 20))
                            .foregroundColor(.primary)
                            .padding(horizontalPaddingForText2())
                        
    //                    ScrollView {
                            ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(viewModel.posts) { post in
                                            HomeCell(post: post)
                                                .frame(width: maxWidthForHVImage())
                                                .padding(horizontalPaddingForSizeClass())
                                        }
                                    }
                            }
    //                    }
    //                    .refreshable {
    //                        do {
    //                            try await viewModel.fetchPosts()
    //                        } catch {
    //                            // Handle the error here, you can log it or display an alert to the user
    //                            print("Error fetching posts: \(error)")
    //                        }
    //                    }
                    }
                    .padding(.top,-10)
                    
                }
                .refreshable {
                    print("fetching")
                    do {
                        try await viewModel.fetchPosts()
                    } catch {
                        // Handle the error here, you can log it or display an alert to the user
                        print("Error fetching posts: \(error)")
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
