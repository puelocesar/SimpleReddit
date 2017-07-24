//
//  Comment.swift
//  SimpleReddit
//
//  Created by Paulo Cesar Ferreira on 04/07/14.
//  Copyright (c) 2014 Paulo Cesar Ferreira. All rights reserved.
//

import UIKit

class Comment: NSObject {
    init(dict : NSDictionary, loadReplies: Bool) {
        
        id = dict["id"] as! String
        body = dict["body"] as! String
        author = dict["author"] as! String
        score = dict["score"] as! Int
        replies = []
        
        super.init()
        
        if loadReplies {
            if let replies = dict["replies"] as? NSDictionary {
                
                if let data = replies["data"] as? NSDictionary {
                    let children = data["children"] as? [NSDictionary]
                    
                    for child in children! {
                        if child["kind"] as! String != "more" {
                            if let data = child["data"] as? NSDictionary {
                                let comment = Comment(dict: data, loadReplies: false)
                                self.replies.append(comment)
                            }
                        }
                    }
                }
            }
        }
    }
    
    override init() {
        id = ""
        body = ""
        author = ""
        score = 0
        replies = []
    }
    
    let id : String
    let author : String
    let body : String
    var replies : Array<Comment>
    let score : Int
}
