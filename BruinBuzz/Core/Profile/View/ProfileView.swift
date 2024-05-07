import SwiftUI

struct ProfileView: View {
    let user: User
    @State var showingBottomSheet = false
    @State private var isImageTapped = false
    
    var body: some View {
        ScrollView {
            // Header
            ProfileHeaderView(user: user)
            
            // Post grid view
            Text("My Events")
                .font(Font.custom("NexaRustSans-Trial-Black2", size: 20))
                .foregroundColor(.primary)
                .padding(.top, 15)
                .padding(.bottom, 1)
                .padding(.leading, -180) // Adjust this value as needed
            
            PostView(user: user)

            Text("Upcoming Events")
                .font(Font.custom("NexaRustSans-Trial-Black2", size: 20))
                .foregroundColor(.primary)
                .padding(.leading, -145) // Adjust this value as needed
                .padding(.top, -20)
                .padding(.bottom, 1)
            
            PostView(user: user)
            
        }
        .navigationTitle("Profile")
        .foregroundColor(.primary)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.MOCK_USERS[1])
    }
}
