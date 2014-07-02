//
//  MainViewController.swift
//  SimpleReddit
//
//  Created by Paulo Cesar Ferreira on 02/07/14.
//  Copyright (c) 2014 Paulo Cesar Ferreira. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    let redditData : RedditData = RedditData();
    
    init(coder aDecoder: NSCoder!) {

        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        func reloadInterface() {
            // chama na thread principal
            dispatch_after(0, dispatch_get_main_queue(), {
                // atualiza a tabela
                self.tableView.reloadData()
            })
        }
        
        self.redditData.reloadData(reloadInterface)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        var number = 0
        
        //if already set items, get count
        if let conta = self.redditData.items?.count {
            number = conta
        }
        
        return number
    }

    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {

        //TODO: recycle cells
        
        let cell = UITableViewCell(frame: CGRectMake(0, 0, 320, 50))
        cell.text = self.redditData.titleForIndex(indexPath!.item)
        
        return cell
    }
    
    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
