import SwiftUI
import MapKit
import Kingfisher

struct HomeCell: View {
    
    // Like implementation changes
    let post: Post
    let gold = Color(UIColor(red: 0.972, green: 0.788, blue: 0.133, alpha: 1.0))
//    let twitterBlue = Color(UIColor(red: 0.016, green: 0.25, blue: 0.47, alpha: 1))
    let twitterBlue = Color(UIColor(red: 0.494, green: 0.752, blue: 0.898, alpha: 1))
    let uclaBlue = Color(UIColor(red: 0.152, green: 0.454, blue: 0.682, alpha: 1))

    
    @ObservedObject var RsvpViewModel: HomeCellViewModel
    
    init(post: Post) {
        self.post = post // I need this
        self.RsvpViewModel = HomeCellViewModel(post: post)
    }
    // Ends here
    
    // Bio changes
    @StateObject var viewModel = UploadPostViewModel()
    @State private var searchText: String = ""
    @State var showingBottomSheet = false
    @State private var isImageTapped = false
    
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
    
    // Padding for the Bottom Sheet Images
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
        VStack(spacing: 15) {
            KFImage(URL(string: post.imageUrl))
                .resizable()
                // orginal - w: 360, h: 535
                //.frame(width: 360, height: 535)
                .frame(maxWidth: maxWidthForImage(), maxHeight: maxHeightForImage())
                .aspectRatio(contentMode: .fill)
                .overlay(
                    OverlayView(post)
                        //.frame(maxWidth: .infinity, maxHeight: .infinity)
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
                        
                        ScrollView {
                            
                            VStack {
                                HStack {
                                    KFImage(URL(string: post.imageUrl))
                                        .resizable()
                                        // Image in bottom sheet
                                        .frame(width: maxWidthForBSImage(), height: maxHeightForBSImage())
                                        .clipShape(CurvedShape())
                                        .overlay(
                                            OverlayView(post)
                                                .frame(width: .infinity, height: .infinity)
                                                .clipShape(.rect(cornerRadius: 15))
                                        )
                                        .padding(.bottom, 5)
                                        .padding(.top, 40)
                                }
                                
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
    //                                MapView()
    //                                    .frame(width: 350, height: 200)
    //                                    .clipShape(CurvedShape())
    //                                    .padding(.top, -1)
                                }
                                .presentationDragIndicator(.visible)
                            }
                    }
                    }
                }
                .clipShape(.rect(cornerRadius: 15))
                .shadow(color: Color.black.opacity(0.25), radius: 8, x: 5, y: 10)
  
            Button {
                RsvpViewModel.post.didRsvp ?? false ?
                RsvpViewModel.unRsvpPost() :
                RsvpViewModel.likePost()
            } label: {
                Text("RSVP")
                    .foregroundColor(RsvpViewModel.post.didRsvp ?? false ? Color(.black) : Color(.white))
                    .padding()
                    .frame(width: 110, height: 50)
                    .background(RsvpViewModel.post.didRsvp ?? false ? gold : Color(.black))
                    .cornerRadius(8)
            }
//            Payment()
//                .padding(.top)
        }
        
    }
}

struct CurvedShape: Shape
{
    func path(in rect: CGRect) -> Path
    {
        let width = rect.size.width
        let height = rect.size.height
        let radius: CGFloat = 30
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: radius))
        path.addQuadCurve(to: CGPoint(x: radius, y: 0), control: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: width - radius, y: 0))
        path.addQuadCurve(to: CGPoint(x: width, y: radius), control: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: height - radius))
        path.addQuadCurve(to: CGPoint(x: width - radius, y: height), control: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: radius, y: height))
        path.addQuadCurve(to: CGPoint(x: 0, y: height - radius), control: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        return path
    }
}

@ViewBuilder
func OverlayView(_ post: Post) -> some View{
    ZStack(alignment: .bottomLeading, content:{
        LinearGradient(colors: [
            .clear,
            .clear,
            .clear,
            .clear,
            .clear,
            .black.opacity(0.1),
            .black.opacity(0.5),
            .black
        ], startPoint: .top, endPoint: .bottom)

        VStack(alignment: .leading, spacing: 4, content: {
            Text(post.title)
                .font(.title2)
                .fontWeight(.black)
                .foregroundStyle(.white)
            Text(post.organization)
                .font(.callout)
                .foregroundStyle(.white.opacity(0.8))
        })
        .padding(20)
    })
}

struct MapView: UIViewRepresentable
{
    func makeUIView(context: Context) -> MKMapView
    {
        MKMapView()
    }

    func updateUIView(_ view: MKMapView, context: Context)
    {
    }
}

struct HomeCell_Previews: PreviewProvider {
    static var previews: some View {
        HomeCell(post: Post.MOCK_POSTS[0])
    }
}
