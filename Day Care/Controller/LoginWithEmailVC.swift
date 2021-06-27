//
//  LoginWithEmailVC.swift
//  Day Care
//
//  Created by Zaman Meraj on 26/09/20.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase


protocol LoginWithEmailVCDelegate {
    func moveToRoleOptionPage()
}

class LoginWithEmailVC: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    let ref = Database.database().reference()
    var delegate:LoginWithEmailVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTF.keyboardType = .emailAddress
        
        self.registerBtn.layer.cornerRadius = 12
        self.registerBtn.clipsToBounds = true
    }
    
    
    @IBAction func registerBtnTapped(_ sender: UIButton) {
        guard let email = self.emailTF.text, let password = self.passwordTF.text, let fullName = self.fullNameTF.text else { return }
        if !(email.isEmpty || password.isEmpty || fullName.isEmpty) {
            self.signInCredential(email: email, password: password, fullName: fullName)
        }
    }
    
    func signInCredential(email: String, password: String, fullName: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                self.showAlert(err: err.localizedDescription)
            }else {
                guard let uid = result?.user.uid else { return }
                print(uid)
                let value = ["displayName": fullName,
                             "email": email]
                self.ref.child("Users").child(uid).setValue(value) { (error, dbRef) in
                    if let err = error  {
                        print(err.localizedDescription)
                    }else {
                        self.dismiss(animated: true) {
                            self.delegate?.moveToRoleOptionPage()
                        }
                    }
                }
            }
        }
    }
    
    
    func showAlert(err: String) {
        
        let alert = UIAlertController(title: "Error", message: err, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}
