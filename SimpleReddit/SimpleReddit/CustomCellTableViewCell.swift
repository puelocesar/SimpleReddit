//
//  CustomCellTableViewCell.swift
//  SimpleReddit
//
//  Created by Paulo Cesar Ferreira on 03/07/14.
//  Copyright (c) 2014 Paulo Cesar Ferreira. All rights reserved.
//

import UIKit

class CustomCellTableViewCell: UITableViewCell, ThumbnailLoadDelegate {

    @IBOutlet var thumbnail: UIImageView?
    @IBOutlet var title: UILabel?
    @IBOutlet var activityIndicator: UIActivityIndicatorView?
    
    @IBOutlet var upvotes: UILabel?
    @IBOutlet var downvotes: UILabel?
    
    
    var linkInfo : LinkInfo?
    
    func formatCell(_ linkInfo: LinkInfo, indexPath: IndexPath) {
        
        self.linkInfo = linkInfo
        
        title?.text = linkInfo.title
        upvotes?.text = String(linkInfo.ups)
        downvotes?.text = String(linkInfo.downs)
        
        if linkInfo.hasThumbnail() {
            linkInfo.delegate = self
            linkInfo.loadImage()
        }
        else {
            activityIndicator?.isHidden = true
            thumbnail?.isHidden = true
            
            title?.frame = CGRect(x: 60, y: 5, width: 250, height: 70)
        }
    }
    
    func thumbnailFinished() {
        DispatchQueue.main.sync(execute: {
            if let image = self.linkInfo?.thumbnail_image {
                self.thumbnail?.image = image
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.activityIndicator?.alpha = 0
                    self.thumbnail?.alpha = 1 })
            }
        })
    }

}
