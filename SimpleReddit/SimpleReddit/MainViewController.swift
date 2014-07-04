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
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: Selector("requestedRefresh"), forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "retrieving posts")
        
        self.refreshControl = refreshControl
        
        //beginRefreshing não chama o refresh adequadamente, por isso temos o setContentOffset
        self.refreshControl.beginRefreshing()
        self.tableView.setContentOffset(CGPointMake(0, self.tableView.contentOffset.y-self.refreshControl.frame.size.height), animated: true)
        self.refreshControl.sendActionsForControlEvents(UIControlEvents.ValueChanged)
    }
    
    func requestedRefresh() {
        
        func reloadInterface(success: Bool) {
            // chama na thread principal
            dispatch_after(0, dispatch_get_main_queue(), {
                
                if success {
                    // atualiza a tabela
                    self.tableView.reloadData()
                }
                
                self.refreshControl.endRefreshing()
            })
        }
        
        self.reddit.reloadData(reloadInterface)
    }

    // #pragma mark - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        //if already set items, get count
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
            
            if (indexPath!.row == 0) {
                performSegueWithIdentifier("showLink", sender: self)
            }
            else {
                println("comments")
                self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
        }
    }
    
    // #pragma mark - navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        let controller = segue.destinationViewController as LinkViewController
        controller.linkInfo = currentLinkInfo
    }
    
}
