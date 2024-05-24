//
//  CircularProfileImageView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/29/24.
//

import SwiftUI
import Kingfisher

enum ProfileImageSize {
    case xSmall
    case small
    case medium
    case large
    
    var dimension: CGFloat {
        switch self {
        case .xSmall:
            return 40
        case .small:
            return 48
        case .medium:
            return 64
        case .large:
            return 80
        }
    }
}

struct CircularProfileImageView: View {
//    let user: User
    let imageUrl: String?
    let size: ProfileImageSize
    

    var body: some View {
        // photo exists on Firebase already
//        if let imageUrl = user.profileImageUrl {
//            KFImage(URL(string: imageUrl))
//                .resizable()
//                .scaledToFill()
//                .frame(width: size.dimension, height: size.dimension)
//                .clipShape(Circle())
//                .onAppear {
//                    print("There is a photo link in Firebase")
//                }
//        } else {
//            // no photo on Firebase - show default person
//            Image(systemName: "person.circle.fill")
//                .resizable()
//                .frame(width: size.dimension, height: size.dimension)
//                .clipShape(Circle())
//                .foregroundColor(.black)
//                .onAppear {
//                    print("No personal image has been selected, this is a new account")
//                }
//        }
        
        // imageUrl can either hold an image or nil - binding
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
                    KFImage(url)
                        .resizable()
                        .scaledToFill()
                        .frame(width: size.dimension, height: size.dimension)
                        .clipShape(Circle())
                        .onAppear {
                            print("There is a photo link in Firebase")
                        }
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: size.dimension, height: size.dimension)
                        .clipShape(Circle())
                        .foregroundColor(.black)
                        .onAppear {
                            print("No personal image has been selected, this is a new account")
                        }
                }

    }
}

struct CircularProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
//        CircularProfileImageView(user: User.MOCK_USERS[0], size: .large)
        CircularProfileImageView(imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/bruinbuzz-638fe.appspot.com/o/profile_images%2F42E0AB68-ED30-4FB6-88C3-995A8E931EBE?alt=media&token=8a3ffb6f-d7bb-47c0-8a59-5e0bc5685d4a", size: .large)
    }
}
