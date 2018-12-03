//
//  registerViewController.swift
//  SpartanDrive
//
//  Created by Pierce Tu on 11/23/18.
//  Copyright © 2018 Pierce Tu. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import Toast_Swift

class registerViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    // Register Button
    @IBAction func registerButton(_ sender: UIButton) {
        guard let emailAddress = emailAddressTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        // Empty text field case.
        if ((firstNameTextField.text?.isEmpty)! || (lastNameTextField.text?.isEmpty)! || (emailAddressTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! || (confirmPasswordTextField.text?.isEmpty)!) {
            self.view.makeToast("Please fill out all the fields for the registration form.")
        }
        
        // Different password value case. Excludes when both empty case.
        else if ((passwordTextField.text?.elementsEqual(confirmPasswordTextField.text!))! != true) {
            self.view.makeToast("Passwords do not match.")
        }
        
        // Register user onto Firebase.
        Auth.auth().createUser(withEmail: emailAddress, password: password) { user, error in
            if(error == nil && user != nil) {
                self.view.makeToast("Registration Successful!")
                self.performSegue(withIdentifier: "registerCompleteSegue", sender: nil)
            }
            else if (error != nil && !(self.firstNameTextField.text?.isEmpty)! && !(self.lastNameTextField.text?.isEmpty)! && !(self.emailAddressTextField.text?.isEmpty)! && !(self.passwordTextField.text?.isEmpty)! && !(self.confirmPasswordTextField.text?.isEmpty)! && (self.passwordTextField.text?.elementsEqual(self.confirmPasswordTextField.text!))! == true){
                self.view.makeToast("Registration Error!")
                print("Error: \(error!.localizedDescription)")
            }
        }
    }
    
    // Back Button
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }


}




