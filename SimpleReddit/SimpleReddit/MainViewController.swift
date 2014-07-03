//
//  MainViewController.swift
//  SimpleReddit
//
//  Created by Paulo Cesar Ferreira on 02/07/14.
//  Copyright (c) 2014 Paulo Cesar Ferreira. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController, UITableViewDelegate {

    let redditData : RedditData = RedditData();
    
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
        
        func reloadInterface() {
            // chama na thread principal
            dispatch_after(0, dispatch_get_main_queue(), {
                // atualiza a tabela
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            })
        }
        
        self.redditData.reloadData(reloadInterface)
    }

    // #pragma mark - Table view data source

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {

        //if already set items, get count
        if let items_count = self.redditData.items?.count {
            return items_count
        }
        else {
            return 0
        }
    }

    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {

        //TODO: recycle cells
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        
        if let data = self.redditData.dataForIndex(indexPath!.item) {
            cell.textLabel.text = data["title"] as String
            
            if data["thumbnail"] as String != "" {
                cell.imageView.image = UIImage(named: "loading.png")
                
                //TODO: baixar imagem em background e mostrar posteriormente
            }
        }
        
        return cell
    }
    
    // #pragma mark - Table view delegate
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        if let data = self.redditData.dataForIndex(indexPath!.item) {
            let url = NSURL(string: data["url"] as String)
            
            //TODO: abrir WebView ao invés de abrir Safari
            UIApplication.sharedApplication().openURL(url)
        }
    }

}
