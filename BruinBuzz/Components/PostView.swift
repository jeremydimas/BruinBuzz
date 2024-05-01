import SwiftUI
import MapKit

struct PostView: View {
    let post: Post
    @State private var showingBottomSheet = false
    @State private var isImageTapped = false

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ScrollView(.horizontal) {
                HStack(spacing: 40) {
                    GeometryReader { proxy in
                        let cardSize = proxy.size
                        let minX = min((proxy.frame(in: .scrollView).minX - 30) * 1.4, proxy.size.width * 1.4)
                        Image(post.imageUrl)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(x: -minX)
                            .frame(width: proxy.size.width * 2.5)
                            .frame(width: cardSize.width, height: cardSize.height)
                            .overlay {
                                OverlayView(post)
                            }
                            .onTapGesture {
                                isImageTapped.toggle()
                                showingBottomSheet.toggle()
                            }
                            .sheet(isPresented: $showingBottomSheet) {
                                HStack {
                                    Image(post.imageUrl)
                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 360, height: 200)
                                        .clipShape(CurvedShape())
                                        .offset(y: -75)
                                        .padding()
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                    .frame(width: 363, height: 600)
                    .scrollTransition(.interactive, axis: .horizontal) { view, phase in
                        view.scaleEffect(phase.isIdentity ? 1 : 0.95)
                    }
                }
                .padding(.horizontal, 30) // changes the horizontal side of the card
                .scrollTargetLayout()
                .frame(height: size.height, alignment: .top)
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal, -15)
    }
}

@ViewBuilder
func OverlayView(_ post: Post) -> some View{
    ZStack(alignment: .bottomLeading, content:{
        LinearGradient(colors:[
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
            Text(post.caption)
                .font(.callout)
                .foregroundStyle(.white.opacity(0.8))
        })
        .padding(20)
    })
}

struct CurvedShape: Shape
{
    func path(in rect: CGRect) -> Path
    {
        let width = rect.size.width
        let height = rect.size.height
        let radius: CGFloat = 30 // Adjust the radius to control the curvature
        
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

struct MapView: UIViewRepresentable
{
    func makeUIView(context: Context) -> MKMapView
    {
        MKMapView()
    }

    func updateUIView(_ view: MKMapView, context: Context)
    {
        // Update the map view if needed
    }
}



// Add CurvedShape and OverlayView definitions here if they're not defined elsewhere in your code

