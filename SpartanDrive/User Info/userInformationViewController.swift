//
//  userInformationViewController.swift
//  SpartanDrive
//
//  Created by Maryam Mostafavi on 11/27/18.
//  Copyright © 2018 Pierce Tu. All rights reserved.
//

import UIKit

class userInformationViewController: UIViewController {

    
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
