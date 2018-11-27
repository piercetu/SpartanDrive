//
//  loginViewController.swift
//  SpartanDrive
//
//  Created by Pierce Tu on 11/4/18.
//  Copyright © 2018 Pierce Tu. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import Firebase
import GoogleSignIn
import Toast_Swift

class loginViewController: UIViewController, GIDSignInUIDelegate {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Google Login Segue.
        if (GIDSignIn.sharedInstance().hasAuthInKeychain()) {
            print("Google Sign In Success")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }
    
    // Custom Google Sign In Button.
    @IBAction func googleSignIn(_ sender: UIButton) {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    // Custom Facebook Sign In Button.
    @IBAction func facebookSignIn(_ sender: UIButton) {
        // Custom Facebook Sign In Button.
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result,error) in
            if error != nil {
                print("Facebook Login Error:", error ?? "NO FB LOGIN ERROR")
                return
            }
//            print("Facebook access token:", result?.token.tokenString ?? "NO FB TOKEN")
            // authenticate on firebase using fb token
            let accessToken = FBSDKAccessToken.current()
            guard let accessTokenString = accessToken?.tokenString else{return }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
            Auth.auth().signInAndRetrieveData(with: credential) { (user, err) in
                if err != nil{
                    print("FB AUTHENTICATION ERROR: ", err ?? "NO FB AUTHENTICATION ERROR")
                    return
                }
                print("FB USERID: ", user ?? "NO LOGIN USERID")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }

    // Firebase Sign In Button
    @IBAction func firebaseSignIn(_ sender: Any) {
        let email = emailTextField.text
        let password = passwordTextField.text
        Auth.auth().signIn(withEmail: email ?? "", password: password ?? "") { (result, error) in
            if (error != nil) {
                self.view.makeToast("Login Error")
            }
            else {
                self.view.makeToast("Firebase Sign In Success")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    // Firebase Register Button
    @IBAction func firebaseRegister(_ sender: UIButton) {
        self.performSegue(withIdentifier: "registerSegue", sender: nil)
    }
    
    
    @IBAction func forgotPasswordButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "resetPasswordSegue", sender: nil)
    }
}
