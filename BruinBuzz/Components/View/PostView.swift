import SwiftUI
//import MapKit
//import Kingfisher

struct PostView: View {
//    @State private var showingBottomSheet = false
//    @State private var isImageTapped = false
    
    @StateObject var viewModel: PostViewModel
    
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
    //            .padding(.leading, -145) // Adjust this value as needed
    //            .padding(.top, -15)
    //            .padding(.bottom, 1)
    
    func horizontalPaddingForText3() -> EdgeInsets {
        let deviceType = DeviceType.current()
        
        switch deviceType {
        case .iPhone8Plus:
            return EdgeInsets(top: 10, leading: -110, bottom: 1, trailing: 0) // Adjust as needed for iPhone 8 Plus
//        case .iPhone11ProMax:
//            return EdgeInsets(top: 1, leading: 37, bottom: 0, trailing: 37) // Adjust as needed for iPhone 11 Pro Max
        case .iPadPro129:
            return EdgeInsets(top: 10, leading: -475, bottom: 1, trailing: 0) // Adjust as needed for iPad Pro 12.9-inch
        case .other:
            switch (horizontalSizeClass, verticalSizeClass) {
            case (.compact, .regular):
                return EdgeInsets(top: 10, leading: -155, bottom: 1, trailing: 0) // iPhone in landscape
            case (.regular, .regular):
                return EdgeInsets(top: 10, leading: -365, bottom: 1, trailing: 0) // iPad
            default:
                return EdgeInsets(top: 10, leading: 37, bottom: 1, trailing: 0)
            }
        }
    }
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: PostViewModel(user: user))
    }

    var body: some View {
        
        Text("My Events")
            .font(Font.custom("NexaRustSans-Trial-Black2", size: 20))
            .foregroundColor(.primary)
//            .padding(.top, 15)
//            .padding(.bottom, 1)
//            .padding(.leading, -180) // Adjust this value as needed
            .padding(horizontalPaddingForText())
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack { // Adjust spacing between posts as needed
                ForEach(viewModel.posts) { post in
                    StoreImage(post: post)
                }
//                .frame(width: 430)
//                .padding(.bottom, 30)
                .frame(width: maxWidthForHVImage()/*, height: maxHeightForHVImage()*/) // 430
                .padding(horizontalPaddingForSizeClass())
            }
        }
        
        Text("Upcoming Events")
            .font(Font.custom("NexaRustSans-Trial-Black2", size: 20))
            .foregroundColor(.primary)
//            .padding(.leading, -145) // Adjust this value as needed
//            .padding(.top, -15)
//            .padding(.bottom, 1)
            .padding(horizontalPaddingForText3())
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.posts(forFilter: .rsvp)) { post in
                    HomeCell(post: post)
                }
//                .frame(width: 430)
//                .padding(.bottom, 30)
                .frame(width: maxWidthForHVImage()/*, height: maxHeightForHVImage()*/) // 430
                .padding(horizontalPaddingForSizeClass())
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(user: User.MOCK_USERS[0])
    }
}


