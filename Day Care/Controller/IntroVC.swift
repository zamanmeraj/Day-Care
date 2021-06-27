//
//  ViewController.swift
//  Day Care
//
//  Created by Zaman Meraj on 19/09/20.
//

import UIKit
import Firebase
import FirebaseDatabase
import GoogleSignIn
import AppAuth

let USER_ID = "uid"
let standard = UserDefaults.standard
class IntroVC: UIViewController {
    var ref = Database.database().reference()
    @IBOutlet weak var headerImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let clientId = "759392343470-lju65mktqppjjtmfemuno2p1anudd3n3.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().clientID = clientId
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        self.setCornerRadius()
    }
    
    func setCornerRadius() {
        self.headerImage.layer.cornerRadius = 12
        self.headerImage.clipsToBounds = true
    }
    
    
    @IBAction func continueWithEmailBtnTapped(_ sender: UIButton) {
        let destination = self.storyboard?.instantiateViewController(identifier: "LoginWithEmailVC") as! LoginWithEmailVC
        destination.delegate = self
        self.present(destination, animated: true, completion: nil)
    }
    
}

extension IntroVC: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("didSignInFor user")
        
        if let err = error {
            print(err.localizedDescription)
            return
        }
        
        
        guard let authentication = user.authentication else { return }
        guard let token = authentication.idToken, let accessToken = authentication.accessToken else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: token,
                                                            accessToken: accessToken)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
            let authError = error as NSError
            print(authError.localizedDescription)
            return
          }
            let uid = authResult!.user.uid
            standard.setValue(uid, forKey: USER_ID)
            
            guard let value = authResult?.additionalUserInfo?.profile as NSDictionary? else { return }
            
            
//            let value: [String: Any] = [:]
            self.ref.child("Users").child(uid).setValue(value) { (error, dbRef) in
                if let err = error {
                    print(err.localizedDescription)
                }else {
                    print(dbRef)
                }
            }            
        }
        let userData = User(gidSignIn: user)
        print(userData)
    }
}

extension IntroVC: LoginWithEmailVCDelegate {
    func moveToRoleOptionPage() {
        let destination = self.storyboard?.instantiateViewController(identifier: "RoleOptionVC") as! RoleOptionVC
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    
}
