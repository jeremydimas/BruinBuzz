import SwiftUI
//import MapKit
//import Kingfisher

struct PostView: View {
//    @State private var showingBottomSheet = false
//    @State private var isImageTapped = false
    
    @StateObject var viewModel: PostViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: PostViewModel(user: user))
    }

    var body: some View {
        
        Text("My Events")
            .font(Font.custom("NexaRustSans-Trial-Black2", size: 20))
            .foregroundColor(.primary)
            .padding(.top, 15)
            .padding(.bottom, 1)
            .padding(.leading, -180) // Adjust this value as needed
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack { // Adjust spacing between posts as needed
                ForEach(viewModel.posts) { post in
                    StoreImage(post: post)
                }
                .frame(width: 430)
                .padding(.bottom, 30)
            }
        }
        
        Text("Upcoming Events")
            .font(Font.custom("NexaRustSans-Trial-Black2", size: 20))
            .foregroundColor(.primary)
            .padding(.leading, -145) // Adjust this value as needed
            .padding(.top, -15)
            .padding(.bottom, 1)
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.posts(forFilter: .rsvp)) { post in
                    HomeCell(post: post)
                }
                .frame(width: 430)
                .padding(.bottom, 30)
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(user: User.MOCK_USERS[0])
    }
}


