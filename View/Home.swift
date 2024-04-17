//
//  Home.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/17/24.
//

import SwiftUI

struct Home: View 
{
    @State private var searchText: String = ""
    
    
    
//    @State var index = 0
    
    var body: some View 
    {
        
        
        
        
        
        
        
        
        ScrollView(.vertical) {
            VStack(spacing: 15) {
                HStack(spacing: 12) {
                    Button(action: {}, label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title)
                            .foregroundStyle(.blue)
                    })
                    HStack(spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)
                        TextField("Search", text: $searchText)
                    }
                    
                    Text("BruinBuzz")
                        .font(Font.custom("MickeyMousePERSONALUSE-Regular", size: 25)).foregroundStyle(
                            LinearGradient(
                                colors: [.orange, .yellow, .orange],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    
                    
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial, in: .capsule)
                }
                /// Parallax Carousel
                GeometryReader(content: {geometry in
                    let size = geometry.size
                    ScrollView(.horizontal) {
                        HStack(spacing: 5) {
                            ForEach(tripCards){card in
                                GeometryReader(content:{proxy in let cardSize = proxy.size
                                    
//                                    let minX = proxy.frame(in:.scrollView).minX - 30.0
                                    
                                    
                                    let minX = min((proxy.frame(in:.scrollView).minX - 30) * 1.4, proxy.size.width * 1.4)
                                    
                                    
                                    Image(card.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .offset(x:-minX)
                                        .frame(width:proxy.size.width * 2.5)
                                        .frame(width:cardSize.width, height: cardSize.height)
                                    
                                        .overlay{
                                            OverlayView(card)
//                                            Text("\(minX)")
//                                                .font(.largeTitle)
//                                                .foregroundStyle(.white)
                                        }
                                    
                                        .clipShape(.rect(cornerRadius: 15))
                                        .shadow(color:.black.opacity(0.25),radius:8,x:5,y:10)
                                })
                                .frame(width:size.width - 60, height: size.height - 50)
                                .scrollTransition(.interactive, axis: .horizontal){view, phase in view .scaleEffect(phase.isIdentity ? 1:0.95)
                                    
                                }
                                
                            }
                        }
                        .padding(.horizontal, 30)
                        .scrollTargetLayout()
                        .frame(height: size.height, alignment: .top)
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollIndicators(.hidden)
                })
                .frame(height: 500)
                .padding(.horizontal, -15)
                .padding(.top, 10)
            }
            .padding(15)
        }
        .scrollIndicators(.hidden)
        
        
//        VStack{
//            Spacer()
//            CustomTabs(index:self.$index)
//        }
//        .background(Color.black.opacity(0.05).edgesIgnoringSafeArea(.top))

    }

    @ViewBuilder
    func OverlayView(_ card: TripCard) -> some View{
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
                Text(card.title)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(.white)
                
                Text(card.subtitle)
                    .font(.callout)
                    .foregroundStyle(.white.opacity(0.8))
            })
            .padding(20)
            
        })
    }
    
    
    
    
//    struct CustomTabs: View
//    {
//        @Binding var index:Int
//        var body:some View{
//            HStack{
//                
//                Button(action:{
//                    self.index = 0
//                }){
//                    Image("home_tab")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width:50, height:50)
//                }
//                .foregroundColor(Color.black.opacity(self.index == 0 ? 1:0.2))
//                .offset(x:30,y:15)
//                Spacer(minLength:0)
//                
//                
//                Button(action:{
//                    
//                }){
//                    Image("add").renderingMode(.original)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width:50, height:50)
//                }
//                .offset(y:15)
//                Spacer(minLength: 0)
//                
//                Button(action:{
//                    self.index = 1
//                }){
//                    Image("profile_tab")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width:50, height:50)
//                }
//                .foregroundColor(Color.black.opacity(self.index == 1 ? 1:0.2))
//                .offset(x:-30,y:15)
//                
//            }
//            .padding(.horizontal, 35)
//            .background(Color.white)
//        }
//    }
    
    
}

#Preview {
    Home()
}
