import SwiftUI

struct SplashScreen: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        
        // Add a ZStack to overlay the gradient background and content
        ZStack {
            // Background gradient
            Color("Royal Blue")
            .ignoresSafeArea()
            
            if isActive {
                ContentView()
            } else {
                VStack {
                    VStack {
                        Image("Icon")
                            .resizable()
                            .aspectRatio(contentMode:.fit)
                            .frame(width: 100)
                        Text("BRUINBUZZ")
                            .shadow(color: .black, radius: 6, x: 4, y: 3)
                            .font(Font.custom("NexaRustSans-Trial-Black2", size: 20)).foregroundStyle(
                                LinearGradient(
                                    colors: [.orange, .yellow, .orange],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 1.25
                            self.opacity = 1.0
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#if DEBUG
struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
#endif
