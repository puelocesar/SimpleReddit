//
//  CommentsViewController.swift
//  SimpleReddit
//
//  Created by Paulo Cesar Ferreira on 04/07/14.
//  Copyright (c) 2014 Paulo Cesar Ferreira. All rights reserved.
//

import UIKit

class CommentsViewController: UITableViewController {

    let reddit : RedditManager = RedditManager()
    var commentId : String?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func requestedRefresh() {
        if let id = commentId {
            self.reddit.retrieveCommentsForId(id, onResult: endRefresh)
        }
    }

    // #pragma mark - Table view data source

    override func numberOfSections(in tableView: UITableView?) -> Int {
        if let items_count = self.reddit.comments?.count {
            return items_count
        }
        else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        
        if let comment = self.reddit.commentForIndex(section) {
            return 1 + comment.replies.count
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell
        var identifier : String
        
        if indexPath.row == 0 {
            identifier = "commentCell"
        }
        else {
            identifier = "subcomment"
        }
        
        if let reusedCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            cell = reusedCell
        }
        else {
            if indexPath.row == 0 {
                let nib = Bundle.main.loadNibNamed("CommentTableCell", owner: self, options: nil)
                cell = nib?[0] as! CommentCell
            }
            else {
                cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: identifier)
                cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 9)
                cell.textLabel?.numberOfLines = 3
            }
        }
        
        if let comment = self.reddit.commentForIndex(indexPath.section) {
            if indexPath.row == 0 {
                if let ccell = cell as? CommentCell {
                    ccell.formatCell(comment)
                }
            }
            else {
                let reply = comment.replies[indexPath.row-1]
                cell.textLabel?.text = "(\(reply.score)) \(reply.author): \(reply.body)"
            }
        }
        else {
            (cell as! CommentCell).cleanCell()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
        heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            if (indexPath.row == 0) {
                return 73
            }
            else {
                return 50
            }
    }

}
