//
//  CommentCell.swift
//  SimpleReddit
//
//  Created by Paulo Cesar Ferreira on 04/07/14.
//  Copyright (c) 2014 Paulo Cesar Ferreira. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet var author: UILabel?
    @IBOutlet var body: UILabel?
    @IBOutlet var score: UILabel?
    
    
    func formatCell(_ comment: Comment) {
        author?.text = comment.author
        body?.text = comment.body
        score?.text = String(comment.score)
    }
    
    func cleanCell() {
        isHidden = true
    }

}
