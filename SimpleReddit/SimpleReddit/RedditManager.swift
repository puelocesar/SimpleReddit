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
    var comments: NSArray?
    
    init () {}
    
    func retrieveLinks(onResult: Bool -> Void) {
        
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
    
    func retrieveCommentsForId(id: String, onResult: Bool -> Void) {
        
        let url = NSURL(string: "http://www.reddit.com/comments/\(id).json")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
            
            if error == nil {
                let content = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSArray
                
                self.comments = content[1]!["data"]!["children"] as? NSArray
                
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
    
    func commentDataForIndex(index : Int) -> Comment? {
        if let array = self.comments {
            if let data = array[index]!["data"] as? NSDictionary {
                if array[index]!["kind"] as String == "more" {
                    return nil
                }
                else {
                    return Comment(dict: data)
                }
            }
        }
        
        return nil
    }
}
