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
            case (.compact, .regular):
                return 372
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
    //            .padding(.leading, -145) // Adjust this value as needed
    //            .padding(.top, -15)
    //            .padding(.bottom, 1)
    
    // Upcoming Events Text Padding
    func horizontalPaddingForText3() -> EdgeInsets {
        let deviceType = DeviceType.current()
        
        switch deviceType {
        case .iPhone8Plus:
            return EdgeInsets(top: 10, leading: -65, bottom: 1, trailing: 0)
        case .iPadPro129:
            return EdgeInsets(top: 10, leading: -475, bottom: 1, trailing: 0)
        case .other:
            switch (horizontalSizeClass, verticalSizeClass) {
            // iPhone
            case (.compact, .regular):
                return EdgeInsets(top: 10, leading: -145, bottom: 1, trailing: 0)
            // iPad
            case (.regular, .regular):
                return EdgeInsets(top: 10, leading: -365, bottom: 1, trailing: 0)
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
            .foregroundColor(.white)
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
            .foregroundColor(.white)
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


