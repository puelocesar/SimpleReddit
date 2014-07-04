//
//  LinkInfo.swift
//  SimpleReddit
//
//  Created by Paulo Cesar Ferreira on 03/07/14.
//  Copyright (c) 2014 Paulo Cesar Ferreira. All rights reserved.
//

import UIKit

protocol ThumbnailLoadDelegate {
    func thumbnailFinished()
}

class LinkInfo: NSObject {
    
    init(dict : NSDictionary) {
        id = dict["id"] as String
        title = dict["title"] as String
        url = dict["url"] as String
        thumbnail = dict["thumbnail"] as String
        comments = dict["num_comments"] as Int
        score = dict["score"] as Int
        
        super.init()
    }
    
    let id : String
    let title : String
    let url : String
    let thumbnail : String
    let comments : Int
    let score : Int
    
    var thumbnail_image : UIImage?
    var delegate : ThumbnailLoadDelegate?
    var thumbnail_loading = false
    
    //utilitario para tratar path do thumb
    func getThumbnailPath() -> String {
        return NSHomeDirectory().stringByAppendingPathComponent("Documents/" +
            self.thumbnail.lastPathComponent)
    }
    
    let backgroundQueue = dispatch_queue_create("com.teste.redditbackground", nil)
    
    //carrega o thumbnail do disco em uma thread
    //se não tiver no disco, começa o download
    func loadImage() {
        dispatch_async(backgroundQueue) {
            if let data = NSData.dataWithContentsOfFile(self.getThumbnailPath(),
                options: nil, error: nil) {
                    
                self.thumbnail_image = UIImage(data: data)
                self.delegate?.thumbnailFinished()
            }
            else {
                self.downloadImage()
            }
        }
    }
    
    // baixa o thumbnail e notifica a interface quando terminar
    func downloadImage() {
        
        if !thumbnail_loading {
            thumbnail_loading = true
            
            let url = NSURL(string: thumbnail)
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
                self.thumbnail_image = UIImage(data: data)
                data.writeToFile(self.getThumbnailPath(), atomically: true)
                self.thumbnail_loading = false
                
                self.delegate?.thumbnailFinished()
            }
            
            task.resume()
        }
    }
    
    //links que não tem thumbnail
    func hasThumbnail() -> Bool {
        return !contains(["", "self", "nsfw", "default"], thumbnail)
    }
}