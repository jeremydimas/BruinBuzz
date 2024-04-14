//
//  SplashScreen.swift
//  BruinBuzz
//
//  Created by Jeremy Dimas on 4/13/24.
//

import SwiftUI

struct SplashScreen: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        
        if isActive{
            ContentView()
        }else{
            VStack{
                VStack{
                    Image("Icon")
                        .resizable()
                        .aspectRatio(contentMode:.fit)
                        .frame(width: 100)
                    Text("BruinBuzz")
                }
                
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)){
                        self.size = 1.25
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                    self.isActive = true
                }
            }
        }
        
        
    }
}

#Preview {
    SplashScreen()
}
