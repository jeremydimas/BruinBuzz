import SwiftUI

struct SplashScreen: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    @StateObject var viewModel = ContentViewModel()
    @StateObject var registrationViewModel = RegistrationViewModel()
    
    let twitterBlue = Color(UIColor(red: 0.494, green: 0.752, blue: 0.898, alpha: 1))
    
    var body: some View {
        
        ZStack {
            if isActive {
                RadialGradient(gradient: Gradient(colors: [.white]), center: .center, startRadius: 500, endRadius: -900)
                    .ignoresSafeArea()
                Group {
                    // xcode suggested $
                    if viewModel.userSession == nil {
                        GuestTabView()
                            .environmentObject(registrationViewModel)
                    } 
                    else if let currentUser = viewModel.currentUser {
                        MainTabView(user: currentUser)
                            .transition(.slide)
                    }
                }
            } else {
                // Background gradient
                RadialGradient(gradient: Gradient(colors: [twitterBlue, .white]), center: .center, startRadius: 500, endRadius: -900)
                    .ignoresSafeArea()
                VStack {
                    Image("Icon")
                        .resizable()
                        .aspectRatio(contentMode:.fit)
                        .frame(width: 100)
                        .shadow(color: .black, radius: 6)
                        .padding(.bottom)
                    
                    Text("BRUINBUZZ")
                        .shadow(color: .black, radius: 4)
                        .font(Font.custom("NexaRustSans-Trial-Black2", size: 20)).foregroundStyle (
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
