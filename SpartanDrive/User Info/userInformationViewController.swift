//
//  userInformationViewController.swift
//  SpartanDrive
//
//  Created by Maryam Mostafavi on 11/27/18.
//  Copyright © 2018 Pierce Tu. All rights reserved.
//

import UIKit
import Firebase

class userInformationViewController: UIViewController {

    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        displayNameLabel.text = "\("Name:  " + String(describing: Auth.auth().currentUser?.displayName ?? "Name:  NO DISPLAY NAME"))"
        emailLabel.text = "\("Email:  " + String(describing: Auth.auth().currentUser?.email ?? "Email:  NO EMAIL"))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        performSegue(withIdentifier: "backUploadSegue", sender: nil)
    }
    
    /*
    // MARK: - Navigation
     @IBAction func userProfile(_ sender: UIButton) {
     }
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
