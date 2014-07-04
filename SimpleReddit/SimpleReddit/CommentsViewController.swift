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
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
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

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        if let items_count = self.reddit.comments?.count {
            return items_count
        }
        else {
            return 0
        }
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        
        if let comment = self.reddit.commentDataForIndex(section) {
            return 1 + comment.replies.count
        }
        
        return 1
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cell : UITableViewCell
        
        if indexPath!.row == 0 {
            if let reusedCell = tableView?.dequeueReusableCellWithIdentifier("commentCell") as? CommentCell {
                cell = reusedCell
            }
            else {
                let nib = NSBundle.mainBundle().loadNibNamed("CommentTableCell", owner: self, options: nil)
                cell = nib[0] as CommentCell
            }
        }
        else {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
            cell.textLabel.font = UIFont(name: "HelveticaNeue-Light", size: 9)
            cell.textLabel.numberOfLines = 3
        }
        
        if let comment = self.reddit.commentDataForIndex(indexPath!.section) {
            if indexPath!.row == 0 {
                (cell as CommentCell).formatCell(comment)
            }
            else {
                let reply = comment.replies[indexPath!.row-1]
                cell.textLabel.text = "\(reply.score) - \(reply.author): \(reply.body)"
            }
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView!,
        heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
            
            if (indexPath.row == 0) {
                return 73
            }
            else {
                return 50
            }
    }

}
