//
//  resetPasswordViewController.swift
//  SpartanDrive
//
//  Created by Pierce Tu on 11/23/18.
//  Copyright © 2018 Pierce Tu. All rights reserved.
//

import Firebase
import UIKit
import Foundation
import Toast_Swift

class resetPasswordViewController: UIViewController {
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBAction func sendEmailButton(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        
        // Empty Email Text Field Case.
        if((emailTextField.text?.isEmpty)!) {
            self.view.makeToast("Please enter in an email address.")
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            // Valid email. Reset email sent.
            if(error == nil) {
                self.view.makeToast("Reset email sent. You will receive your email shortly.")
            }
            
            // Invalid email case.
            else {
                self.view.makeToast("Please enter a valid email address.")
            }
        }
    }
    override func viewDidLoad() {
        sendBtn.layer.cornerRadius = 10
    }
    // Go back to login page.
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
