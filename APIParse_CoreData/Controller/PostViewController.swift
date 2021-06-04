//
//  PostViewController.swift
//  APIParse_CoreData
//
//  Created by Mirajkar on 04/06/21.
//  Copyright © 2021 Mirajkar. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    //MARK: Global variables
    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.getPosts { (message) in
            self.tableView.reloadData()
        }
    }
}


extension PostViewController : UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DatabaseManager.shared.fetchPostsData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as! PostTableViewCell
        let postObj = DatabaseManager.shared.fetchPostsData()[indexPath.row]
        cell.nameLabel.text = postObj.value(forKey: "name") as? String
        cell.emailLabel.text = postObj.value(forKey: "email") as? String
        return cell
    }
    
    // MARK: UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postObj = DatabaseManager.shared.fetchPostsData()[indexPath.row]
        let name = postObj.value(forKey: "name") as? String
        let comment = postObj.value(forKey: "comment") as? String
        
        let alert = UIAlertController.init(title: name, message: comment, preferredStyle:.alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let postObj = DatabaseManager.shared.fetchPostsData()[indexPath.row]

        DatabaseManager.shared.deleteObject(postObject: postObj)
        tableView.reloadData()
    }
}
