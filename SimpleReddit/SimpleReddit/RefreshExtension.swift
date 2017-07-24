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
        self.refreshControl?.addTarget(self, action: Selector("requestedRefresh"), for: UIControlEvents.valueChanged)
        
        //beginRefreshing não chama o refresh adequadamente, por isso temos o setContentOffset
        self.refreshControl?.beginRefreshing()
        self.tableView.setContentOffset(CGPoint(x: 0, y: self.tableView.contentOffset.y-(self.refreshControl?.frame.size.height)!), animated: true)
        self.refreshControl?.sendActions(for: UIControlEvents.valueChanged)
    }
    
    func endRefresh(_ success: Bool) {
        // chama na thread principal
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
            
            if success {
                // atualiza a tabela
                self.tableView.reloadData()
            }
            
            self.refreshControl?.endRefreshing()
        })
    }
}
