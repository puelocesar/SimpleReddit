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

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {

        //if already set items, get count
        if let items_count = self.reddit.items?.count {
            return items_count
        }
        else {
            return 0
        }
    }

    override func tableView(tableView: UITableView?,
        cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {

        let identifier = "CustomTableCell"
        var cell : CustomCellTableViewCell
        
        if let reusedCell = tableView?.dequeueReusableCellWithIdentifier(identifier) as? CustomCellTableViewCell {
            cell = reusedCell
        }
        else {
            let nib = NSBundle.mainBundle().loadNibNamed("CustomTableCell",
                owner: self, options: nil)
            cell = nib[0] as CustomCellTableViewCell
        }
        
        if let linkInfo = self.reddit.dataForIndex(indexPath!.row) {
            //linkInfo.delegate = self
            cell.formatCell(linkInfo, indexPath: indexPath!)
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView!,
        heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
            
        return 80
    }
    
    // #pragma mark - Table view delegate
    
    var currentLinkInfo : LinkInfo?
    
    override func tableView(tableView: UITableView!,
        didSelectRowAtIndexPath indexPath: NSIndexPath!) {
            
        if let data = self.reddit.dataForIndex(indexPath!.row) {
            currentLinkInfo = data
            performSegueWithIdentifier("showLink", sender: self)
        }
    }
    
    // #pragma mark - navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        let controller = segue.destinationViewController as LinkViewController
        controller.linkInfo = currentLinkInfo
    }
    
}
