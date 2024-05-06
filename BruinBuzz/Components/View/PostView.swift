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
        ScrollView(.horizontal, showsIndicators: false) {
            HStack { // Adjust spacing between posts as needed
                ForEach(viewModel.posts) { post in
                    StoreImage(post: post)
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


