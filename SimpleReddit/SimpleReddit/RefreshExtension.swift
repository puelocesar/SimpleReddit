//
//  RefreshExtension.swift
//  SimpleReddit
//
//  Created by Paulo Cesar Ferreira on 04/07/14.
//  Copyright (c) 2014 Paulo Cesar Ferreira. All rights reserved.
//

import UIKit

extension UITableViewController {
    
    func setupRefreshControl() {
        self.refreshControl.addTarget(self, action: Selector("requestedRefresh"), forControlEvents: UIControlEvents.ValueChanged)
        
        //beginRefreshing não chama o refresh adequadamente, por isso temos o setContentOffset
        self.refreshControl.beginRefreshing()
        self.tableView.setContentOffset(CGPointMake(0, self.tableView.contentOffset.y-self.refreshControl.frame.size.height), animated: true)
        self.refreshControl.sendActionsForControlEvents(UIControlEvents.ValueChanged)
    }
    
    func endRefresh(success: Bool) {
        // chama na thread principal
        dispatch_after(0, dispatch_get_main_queue(), {
            
            if success {
                // atualiza a tabela
                self.tableView.reloadData()
            }
            
            self.refreshControl.endRefreshing()
        })
    }
}