//
//  CustomCellTableViewCell.swift
//  SimpleReddit
//
//  Created by Paulo Cesar Ferreira on 03/07/14.
//  Copyright (c) 2014 Paulo Cesar Ferreira. All rights reserved.
//

import UIKit

class CustomCellTableViewCell: UITableViewCell {

    @IBOutlet var thumbnail: UIImageView
    @IBOutlet var title: UILabel
    @IBOutlet var comments: UILabel
    @IBOutlet var activityIndicator: UIActivityIndicatorView
    
    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func formatCell(data: LinkInfo) {
        title.text = data.title
        comments.text = String(data.comments) + " comments"
        
        if data.thumbnail == "" {
            activityIndicator.hidden = true
            thumbnail.hidden = true
            
            title.frame = CGRectMake(20, 5, 280, 45)
            comments.frame = CGRectMake(20, 58, 100, 21)
        }
    }

}
