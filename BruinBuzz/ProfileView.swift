//
//  ProfileView.swift
//  BruinBuzz
//
//  Created by Jeremy Dimas on 4/18/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack{
            //header
            Text("Profile")
                .font(.custom("Footnote", size: 24))
                .fontWeight(.bold)
                .font(.system(size: 50))
                .padding(.top,30)
            VStack(spacing:10){
                //pic and stats
                HStack
                {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    
                    Spacer()
                    
                    HStack(spacing: 0){
                        UserStatView(value: 3, title: "Events")
                    }
//
                }
                .padding(.horizontal)
                
                //name and bio
                VStack(alignment:.leading, spacing: 4){
                    Text("Username")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Text("Additional Info")
                        .font(.footnote)
                        
                }
                .frame(maxWidth:.infinity, alignment:.leading)
                .padding(.horizontal)
                
                //action button
                
                Button{
                    
                }label:{
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width:360, height: 32) //w:360
                        .foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray,lineWidth: 1))
                }
                Divider()
                
            }
            //post grid view
            
            
            
            Text("My Events")
                .font(Font.custom("MickeyMousePERSONALUSE-Regular", size: 25)).foregroundStyle(
                    LinearGradient(
                        colors: [.orange, .yellow, .orange],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .padding(.top,15)
            
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
            .frame(height: 400) //500
            .padding(.horizontal, -15)
            .padding(.top, 15)
        }
        .padding(15)
        
    }
    
//    .scrollIndicators(.hidden)
    
    
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
            
            
//        }
//    }
//}

struct ProfileView_Previews: PreviewProvider{
    static var previews: some View{
        ProfileView()
    }
}


//#Preview {
//    ProfileView()
//}
