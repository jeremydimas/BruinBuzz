import SwiftUI

struct ProfileView: View {
    let user: User
    
    @StateObject private var viewModel: PostViewModel
    
    @State private var refreshedUser: User? = nil
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: PostViewModel(user: user))
    }
    
    @State var showingBottomSheet = false
    @State private var isImageTapped = false
    
    var body: some View {
        ScrollView {
            // Header
            ProfileHeaderView(user: user)
            
            PostView(user: user)
        }
        .navigationTitle("Profile")
        .foregroundColor(.primary)
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.MOCK_USERS[1])
    }
}
