//
//  CustomCellTableViewCell.swift
//  SimpleReddit
//
//  Created by Paulo Cesar Ferreira on 03/07/14.
//  Copyright (c) 2014 Paulo Cesar Ferreira. All rights reserved.
//

import UIKit

class CustomCellTableViewCell: UITableViewCell, ThumbnailLoadDelegate {

    @IBOutlet var thumbnail: UIImageView
    @IBOutlet var title: UILabel
    @IBOutlet var comments: UILabel
    @IBOutlet var activityIndicator: UIActivityIndicatorView
    
    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    var linkInfo : LinkInfo?
    
    func formatCell(linkInfo: LinkInfo, indexPath: NSIndexPath) {
        
        self.linkInfo = linkInfo
        
        title.text = linkInfo.title
        comments.text = String(linkInfo.comments) + " comments"
        
        if linkInfo.hasThumbnail() {
            linkInfo.delegate = self
            linkInfo.loadImage()
        }
        else {
            activityIndicator.hidden = true
            thumbnail.hidden = true
            
            title.frame = CGRectMake(20, 5, 280, 45)
            comments.frame = CGRectMake(20, 58, 100, 21)
        }
    }
    
    func thumbnailFinished() {
        dispatch_sync(dispatch_get_main_queue(), {
            if let image = self.linkInfo?.thumbnail_image {
                self.thumbnail.image = image
                
                UIView.animateWithDuration(0.2, animations: {
                    self.activityIndicator.alpha = 0
                    self.thumbnail.alpha = 1 })
            }
        })
    }

}
