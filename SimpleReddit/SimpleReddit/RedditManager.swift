//
//  RedditData.swift
//  SimpleReddit
//
//  Created by Paulo Cesar Ferreira on 02/07/14.
//  Copyright (c) 2014 Paulo Cesar Ferreira. All rights reserved.
//

import UIKit

class RedditManager {
    
    var items: [[String: Any]]?
    var comments: [[String: Any]]?
    
    init () {}
    
    func retrieveLinks(_ onResult: @escaping (Bool) -> Void) {
        
        let url = URL(string: "http://www.reddit.com/hot.json")
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            if error == nil {
                if let content = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String, Any> {
                    
                    if let data = content["data"] as? Dictionary<String, Any> {
                        self.items = data["children"] as? [[String: Any]]
                    }
                }
                
                //chamar delegate para a interface
                onResult(true)
            }
            else {
                onResult(false)
            }
            
        }
        
        task.resume()
    }
    
    func linkInfoForIndex(_ index : Int) -> LinkInfo? {
        if let array = self.items {
            if let data = array[index]["data"] as? NSDictionary {
                return LinkInfo(dict: data)
            }
        }
        
        return nil
    }
    
    func retrieveCommentsForId(_ id: String, onResult: @escaping (Bool) -> Void) {
        
        let url = URL(string: "http://www.reddit.com/comments/\(id).json?depth=2")
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            if error == nil {
                if let content = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: Any]] {
                    
                    if let data = content[1]["data"] as? Dictionary<String, Any> {
                        self.comments = data["children"] as? [[String: Any]]
                        
                        onResult(true)
                    }
                } else {
                    onResult(false)
                }
                
            }
            else {
                onResult(false)
            }
            
        }
        
        task.resume()
    }
    
    func commentForIndex(_ index : Int) -> Comment? {
        if let array = self.comments {
            if let data = array[index]["data"] as? NSDictionary {
                if array[index]["kind"] as? String == "more" {
                    return nil
                }
                else {
                    return Comment(dict: data, loadReplies: true)
                }
            }
        }
        
        return nil
    }
}
