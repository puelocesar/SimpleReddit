//
//  RedditData.swift
//  SimpleReddit
//
//  Created by Paulo Cesar Ferreira on 02/07/14.
//  Copyright (c) 2014 Paulo Cesar Ferreira. All rights reserved.
//

import UIKit

class RedditManager {
    
    var items: NSArray?
    
    init () {}
    
    func reloadData(onResult: Bool -> Void) {
        
        let url = NSURL(string: "http://www.reddit.com/hot.json")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
            
            if error == nil {
                let content = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                
                self.items = content["data"]!["children"] as? NSArray
                
                //chamar delegate para a interface
                onResult(true)
            }
            else {
                println(error.description)
                onResult(false)
            }
            
        }
        
        task.resume()
    }
    
    func dataForIndex(index : Int) -> LinkInfo? {
        if let array = self.items {
            if let data = array[index]!["data"] as? NSDictionary {
                return LinkInfo(dict: data)
            }
        }
        
        return nil
    }
}
