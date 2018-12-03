//
//  photoTableViewController.swift
//  SpartanDrive
//
//  Created by Pierce Tu on 12/1/18.
//  Copyright © 2018 Pierce Tu. All rights reserved.
//

import UIKit
import Firebase

class photoTableViewController: UITableViewController {
    var urllist: [String] = []
    let cellid = "cellid"
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        fetchPhotos();
    }
    
    func fetchPhotos(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("User").child(uid).observe(DataEventType.childAdded) { (snapshot) in
            let value = snapshot.value as? String;
            print("downloadurl: ")
            print(value!);
            self.urllist.append(value!)
            DispatchQueue.main.async {
                self.tableView.reloadData();
            }
            
        }
    }
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return urllist.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellid)
        //let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        cell.textLabel?.text = urllist[indexPath.row]
        let imageURL = urllist[indexPath.row]
        //let url = URL(string: imageURL)
        print("tryto download")
        let url = URL(string: imageURL)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, res, err) in
            if(err != nil){
                print("error with download image")
                return
            }
            else{
                DispatchQueue.main.async {
                    cell.imageView?.image = UIImage(data: data!);
                }
            }
        }).resume()
        
        
        return cell
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.rowHeight = 100;
    }
    
    
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
