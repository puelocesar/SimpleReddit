//
//  LinkInfo.swift
//  SimpleReddit
//
//  Created by Paulo Cesar Ferreira on 03/07/14.
//  Copyright (c) 2014 Paulo Cesar Ferreira. All rights reserved.
//

import UIKit

class LinkInfo: NSObject {
    
    init(dict : NSDictionary) {
        id = dict["id"] as String
        title = dict["title"] as String
        url = dict["url"] as String
        thumbnail = dict["thumbnail"] as String
        comments = dict["num_comments"] as Int
        score = dict["score"] as Int
    }
    
    let id : String
    let title : String
    let url : String
    let thumbnail : String
    let comments : Int
    let score : Int
    
    var thumbnail_image : UIImage?
}