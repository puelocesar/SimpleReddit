//
//  Downloader.swift
//  SimpleReddit
//
//  Created by Paulo Cesar Ferreira on 02/07/14.
//  Copyright (c) 2014 Paulo Cesar Ferreira. All rights reserved.
//

import Foundation

class SimpleDownloader {
    
    func downloadWithURLString(string_url: NSString) {

        var url = NSURL(string: string_url)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        
        task.resume()
    }
}
