//
//  MainViewController.swift
//  SimpleReddit
//
//  Created by Paulo Cesar Ferreira on 02/07/14.
//  Copyright (c) 2014 Paulo Cesar Ferreira. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    let reddit : RedditManager = RedditManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func requestedRefresh() {
        self.reddit.retrieveLinks(endRefresh)
    }

    // #pragma mark - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let items_count = self.reddit.items?.count {
            return items_count
        }
        else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if (indexPath.row == 1) {
            
            var cell : UITableViewCell
            
            if let reusedCell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell") {
                cell = reusedCell
            }
            else {
                cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "CommentsCell")
                cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 14)
            }
            
            if let linkInfo = self.reddit.linkInfoForIndex(indexPath.section) {
                cell.textLabel?.text = String(linkInfo.comments) + " comments"
            }
            
            return cell
        }
        else {
            var cell : CustomCellTableViewCell
            
            if let reusedCell = tableView.dequeueReusableCell(withIdentifier: "CustomTableCell") as? CustomCellTableViewCell {
                cell = reusedCell
            }
            else {
                let nib = Bundle.main.loadNibNamed("CustomTableCell",
                    owner: self, options: nil)
                cell = nib?[0] as! CustomCellTableViewCell
            }
            
            if let linkInfo = self.reddit.linkInfoForIndex(indexPath.section) {
                cell.formatCell(linkInfo, indexPath: indexPath)
            }
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView,
        heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.row == 0) {
            return 80
        }
        else {
            return 30
        }
    }
    
    // #pragma mark - Table view delegate
    
    var currentLinkInfo : LinkInfo?
    
    override func tableView(_ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
            
        if let data = self.reddit.linkInfoForIndex(indexPath.section) {
            currentLinkInfo = data
            
            var identifier : String
            
            if (indexPath.row == 0) {
                identifier = "showLink"
            }
            else {
                identifier = "showComments"
            }
            
            performSegue(withIdentifier: identifier, sender: self)
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // #pragma mark - navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "showLink") {
            let controller = segue.destination as! LinkViewController
            controller.linkInfo = currentLinkInfo
        }
        else {
            let controller = segue.destination as! CommentsViewController
            controller.commentId = currentLinkInfo!.id
        }
    }
    
}
