//
//  uploadViewController.swift
//  SpartanDrive
//
//  Created by Pierce Tu on 11/4/18.
//  Copyright © 2018 Pierce Tu. All rights reserved.
//

import UIKit
import FacebookLogin
import Firebase
import GoogleSignIn
import FirebaseStorage
import FirebaseDatabase
import FBSDKLoginKit

class uploadViewController: UIViewController, UINavigationControllerDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var uploadProgressLabel: UILabel!
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var menu: UIView!
    //let your_firebase_storage_bucket = FirebaseOptions.defaultOptions()?.storageBucket ?? ""
    @IBOutlet weak var menuBar: UIView!
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet var buttons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Indicator for Login Method.
        if (GIDSignIn.sharedInstance().hasAuthInKeychain()) {
            // Google
            self.view.makeToast("Google Login Success!")
        }
        else if ((FBSDKAccessToken.current()) != nil) {
            // Facebook
            self.view.makeToast("Facebook Login Success!")
        }
        else {
            // Firebase
            self.view.makeToast("Firebasee Login Success!")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Unique name for file uploaded.
    let filenameJPG : String = "\(NSUUID().uuidString).jpg"
    
    // Image Reference creates folder named "images" in Firebase Storage.
    var imageReference: StorageReference {
        return Storage.storage().reference().child("images")
    }
    
    // Select Image from Photo Library.
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage.image = image
        }
        else {
            print("Error selecting an image")
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    // Select Image from Photo Library.
    @IBAction func selectTapped(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self

        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false

        self.present(image, animated: true) {
        }
    }
    
    // Upload Button
    @IBAction func menuButtonAction(_ sender: Any) {
    }
    @IBAction func listButtonAction(_ sender: Any) {
    }
    @IBAction func uploadTapped(_ sender: UIButton) {
        guard let image = selectedImage.image else { return  }
        guard let imageData = image.jpegData(compressionQuality: 1) else { return }
        let uploadImageRef = imageReference.child(filenameJPG)
        let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
            print("UPLOAD COMPLETE")
            print(metadata ?? "NO METADATA")
            print(error ?? "NO ERROR")
        }
        
        // UILabel for Upload in Progress.
        uploadTask.observe(.progress) { (snapshot) in
            self.uploadProgressLabel.text = ("Uploading...")
        }
        
        // UILabel for Upload Complete.
        uploadTask.observe(.success) { (snapshot) in
            self.uploadProgressLabel.text = ("Upload Complete")
            print(snapshot.progress ?? "Upload Complete")
        }
        
        uploadTask.resume()
    }
    
    // CollectionView of Files uploaded.
    @IBAction func viewFilesButton(_ sender: Any) {
        performSegue(withIdentifier: "viewFilesSegue", sender: nil)
    }
    
    // Universal Sign Out Button. Go back to Login page.
    @IBAction func universalSignOut(_ sender: UIButton) {
        // Google Sign Out.
        if ((GIDSignIn.sharedInstance()?.hasAuthInKeychain()) != nil) {
            GIDSignIn.sharedInstance().signOut()
            print("Google Sign Out Success!")
            self.dismiss(animated: true)
            self.view.makeToast("Google Sign Out Success!")
        }
            
        // Facebook Sign Out.
        else if ((FBSDKAccessToken.current()) != nil) {
            FBSDKLoginManager().logOut()
            print("Facebook Sign Out Success!")
            self.dismiss(animated: true)
        }
        
        // Firebase Sign Out.
        else {
            print("Firebase Sign Out Success!")
            self.dismiss(animated: true)
        }
    }
}
