//
//  Comment.swift
//  SimpleReddit
//
//  Created by Paulo Cesar Ferreira on 04/07/14.
//  Copyright (c) 2014 Paulo Cesar Ferreira. All rights reserved.
//

import UIKit

class Comment: NSObject {
    init(dict : NSDictionary) {
        
        id = dict["id"] as String
        body = dict["body"] as String
        ups = dict["ups"] as Int
        downs = dict["downs"] as Int
        comments = []
        
        super.init()
    }
    
    let id : String
    let body : String
    let comments : NSArray
    let ups : Int
    let downs : Int
}
