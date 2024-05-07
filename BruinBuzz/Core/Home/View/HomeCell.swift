//
//  Home.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/17/24.
//

import SwiftUI
import MapKit
import Kingfisher

struct HomeCell: View {
    let post: Post
    
    //bio changes
    @StateObject var viewModel = UploadPostViewModel()
    // ends here
    @State private var searchText: String = ""
    @State var showingBottomSheet = false
    @State private var isImageTapped = false
    
    var body: some View {
        VStack(spacing: 15) {
            KFImage(URL(string: post.imageUrl))
                .resizable()
                .frame(width: 360, height: 550)
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
                            .padding(.bottom, 5)
                    }
                    .edgesIgnoringSafeArea(.all)
                    
                    HStack {
                        Text("Organizer:")
                            .fontWeight(.bold)
                        Text(post.organizer)
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
            
            Payment()
                .padding(.top)
        }
        
    }
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
        // Update the map view if needed
    }
}

struct HomeCell_Previews: PreviewProvider {
    static var previews: some View {
        HomeCell(post: Post.MOCK_POSTS[0])
    }
}
