import SwiftUI

struct ProfileView: View {
    let user: User
    
//    let twitterBlue = Color(UIColor(red: 0.016, green: 0.25, blue: 0.47, alpha: 1))
    let twitterBlue = Color(UIColor(red: 0.494, green: 0.752, blue: 0.898, alpha: 1))
    
    @StateObject private var viewModel: PostViewModel
    
    @State private var refreshedUser: User? = nil
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: PostViewModel(user: user))
    }
    
    @State var showingBottomSheet = false
    @State private var isImageTapped = false
    
    var body: some View {
        
        ZStack {
            RadialGradient(gradient: Gradient(colors: [ .white]), center: .center, startRadius: 500, endRadius: -900)
                .ignoresSafeArea()
            
            ScrollView {
                // Header
                
                HStack {
                    Spacer()

                    
                    Text("Profile")
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                    
                    Spacer()
                                            

                }
                .padding(.top, -32)
                
                ProfileHeaderView(user: user)
                
                PostView(user: user)
            }
            .foregroundColor(.white)
            .navigationBarTitleDisplayMode(.inline)
            .refreshable {
                print("refreshing..")
                do {
                    try await viewModel.fetchUserPosts()
                    refreshedUser = user // Update refreshedUser after fetching user posts

                } catch {
                    // Handle the error here, such as showing an alert to the user
                    print("Error fetching user posts: \(error)")
                }
                // Reset refreshedUser state after each refresh
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    refreshedUser = nil
                }
            }
        }
    
        

    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.MOCK_USERS[1])
    }
}
