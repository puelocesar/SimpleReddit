//
//  MainViewController.swift
//  SimpleReddit
//
//  Created by Paulo Cesar Ferreira on 02/07/14.
//  Copyright (c) 2014 Paulo Cesar Ferreira. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController, UITableViewDelegate {

    let reddit : RedditManager = RedditManager();
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func requestedRefresh() {
        self.reddit.retrieveLinks(endRefresh)
    }

    // #pragma mark - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        if let items_count = self.reddit.items?.count {
            return items_count
        }
        else {
            return 0
        }
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }

    override func tableView(tableView: UITableView?,
        cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {

        if (indexPath?.row == 1) {
            
            var cell : UITableViewCell
            
            if let reusedCell = tableView?.dequeueReusableCellWithIdentifier("CommentsCell") as? UITableViewCell {
                cell = reusedCell
            }
            else {
                cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "CommentsCell")
                cell.textLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14)
            }
            
            if let linkInfo = self.reddit.dataForIndex(indexPath!.section) {
                cell.textLabel.text = String(linkInfo.comments) + " comments"
            }
            
            return cell
        }
        else {
            var cell : CustomCellTableViewCell
            
            if let reusedCell = tableView?.dequeueReusableCellWithIdentifier("CustomTableCell") as? CustomCellTableViewCell {
                cell = reusedCell
            }
            else {
                let nib = NSBundle.mainBundle().loadNibNamed("CustomTableCell",
                    owner: self, options: nil)
                cell = nib[0] as CustomCellTableViewCell
            }
            
            if let linkInfo = self.reddit.dataForIndex(indexPath!.section) {
                cell.formatCell(linkInfo, indexPath: indexPath!)
            }
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView!,
        heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        
        if (indexPath.row == 0) {
            return 80
        }
        else {
            return 30
        }
    }
    
    // #pragma mark - Table view delegate
    
    var currentLinkInfo : LinkInfo?
    
    override func tableView(tableView: UITableView!,
        didSelectRowAtIndexPath indexPath: NSIndexPath!) {
            
        if let data = self.reddit.dataForIndex(indexPath!.section) {
            currentLinkInfo = data
            
            var identifier : String
            
            if (indexPath!.row == 0) {
                identifier = "showLink"
            }
            else {
                identifier = "showComments"
            }
            
            performSegueWithIdentifier(identifier, sender: self)
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    // #pragma mark - navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "showLink") {
            let controller = segue.destinationViewController as LinkViewController
            controller.linkInfo = currentLinkInfo
        }
        else {
            let controller = segue.destinationViewController as CommentsViewController
            controller.commentId = currentLinkInfo!.id
        }
    }
    
}
