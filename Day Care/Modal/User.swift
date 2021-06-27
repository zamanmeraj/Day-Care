//
//  User.swift
//  Day Care
//
//  Created by Zaman Meraj on 19/09/20.
//

import Foundation
import UIKit
import GoogleSignIn
import Kingfisher
struct User {
    var name: String!
    var email: String!
    var userID:String!
    var image: UIImage?
    var imageURL: URL?
    init(gidSignIn: GIDGoogleUser) {
        let user = gidSignIn.profile!
        self.name = user.name
        self.email = user.email
        self.userID = gidSignIn.userID
        
        if user.hasImage {
            self.imageURL = user.imageURL(withDimension: 60)
            let imageView = UIImageView()
             imageView.kf.setImage(with: self.imageURL!)
            self.image = imageView.image
        }
        
    }
    
}
