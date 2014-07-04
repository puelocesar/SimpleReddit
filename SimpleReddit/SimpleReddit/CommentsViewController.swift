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
        return 1
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
        
        if let comment = self.reddit.commentDataForIndex(indexPath!.section) {
            cell.textLabel.text = comment.body
        }
        
        return cell
    }

}
