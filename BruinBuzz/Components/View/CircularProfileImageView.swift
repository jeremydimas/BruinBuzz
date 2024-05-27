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
                .foregroundColor(.primary)
                .onAppear {
                    print("No personal image has been selected, this is a new account")
                }
        }

    }
}

struct CircularProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
//        CircularProfileImageView(user: User.MOCK_USERS[0], size: .large)
        CircularProfileImageView(imageUrl: "https://example.com/mock_profile_image.jpg", size: .large)
    }
}
