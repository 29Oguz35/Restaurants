//
//  CommentsTableViewController.swift
//  Restaurant
//
//  Created by naruto kurama on 31.05.2022.
//

import UIKit

class CommentsTableViewController: UITableViewController {
    
    var comments : [Review]? {
        didSet {
            print("yorumlar atandı")
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

  

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return comments?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsTableViewCell", for: indexPath) as! CommentsTableViewCell
        let comment = comments![indexPath.row]
        
        cell.lblName.text = comment.user.name
        cell.lblScore.text = "Score: \(comment.rating) / 5"
        cell.lblComment.text = comment.text
        cell.imgUser.af.setImage(withURL: comment.user.image_url)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
        
    }

}
