//
//  RedditData.swift
//  SimpleReddit
//
//  Created by Paulo Cesar Ferreira on 02/07/14.
//  Copyright (c) 2014 Paulo Cesar Ferreira. All rights reserved.
//

import UIKit

class RedditData {
    
    var items: NSArray?
    
    init () {}
    
    func reloadData(onResult: Void -> Void) {
        
        let url = NSURL(string: "http://www.reddit.com/hot.json")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
            
            //salvar arquivo
            
            let content = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            
            self.items = content["data"]!["children"] as? NSArray
            
            //chamar delegate para a interface
            onResult()
        }
        
        task.resume()
    }
    
    func titleForIndex(index : Int) -> String {
        if let array = self.items {
            return array[index]!["data"]!["title"] as String
        }
        
        return ""
    }
}
