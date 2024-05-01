import SwiftUI

struct ProfileView: View {
    
    let user: User
    @State var showingBottomSheet = false
    @State private var isImageTapped = false

    var posts: [Post] {
        return Post.MOCK_POSTS.filter({ $0.user?.username == user.username })
    }
    
    var body: some View {
        ScrollView {
            // Header
            ProfileHeaderView(user: user)
            
            // Post grid view
            Text("My Events")
                .font(Font.custom("MickeyMousePERSONALUSE-Regular", size: 25))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.orange, .yellow, .orange],
                        startPoint: .leading,
                        endPoint: .trailing)
                )
                .padding(.top, 15)
                .padding(.bottom, 15)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack { // Adjust spacing between posts as needed
                    ForEach(posts) { post in
                        PostView(post: post) // Use PostView here
                            .frame(width: 400, height: 650)
        //                    .padding(.bottom)
                    }
                }
            }
            
            
            Text("Upcoming Events")
                .font(Font.custom("MickeyMousePERSONALUSE-Regular", size: 25))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.orange, .yellow, .orange],
                        startPoint: .leading,
                        endPoint: .trailing)
                )
                .padding(.top, -30)
                .padding(.bottom, 10)
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack { // Adjust spacing between posts as needed
                    ForEach(posts) { post in
                        PostView(post: post) // Use PostView here
                            .frame(width: 400, height: 650)
        //                    .padding(.bottom)
                    }
                }
            }

            
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View{
        ProfileView(user: User.MOCK_USERS[1])
    }
}
