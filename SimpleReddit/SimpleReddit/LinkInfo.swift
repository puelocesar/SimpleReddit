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
        id = dict["id"] as! String
        title = dict["title"] as! String
        url = dict["url"] as! String
        thumbnail = dict["thumbnail"] as! String
        comments = dict["num_comments"] as! Int
        ups = dict["ups"] as! Int
        downs = dict["downs"] as! Int
        
        super.init()
    }
    
    let id : String
    let title : String
    let url : String
    let thumbnail : String
    let comments : Int
    let ups : Int
    let downs : Int
    
    var thumbnail_image : UIImage?
    var delegate : ThumbnailLoadDelegate?
    var thumbnail_loading = false
    
    //utilitario para tratar path do thumb
    func getThumbnailPath() -> String {
        return (NSHomeDirectory() as NSString).appendingPathComponent("Documents/" +
            (self.thumbnail as NSString).lastPathComponent)
    }
    
    let backgroundQueue = DispatchQueue(label: "com.teste.redditbackground", attributes: [])
    
    //carrega o thumbnail do disco em uma thread
    //se não tiver no disco, começa o download
    func loadImage() {
        backgroundQueue.async {
            if let data = NSData(contentsOfFile: self.getThumbnailPath()) {
                    
                self.thumbnail_image = UIImage(data: data as Data)
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
            
            let url = URL(string: thumbnail)
            let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
                self.thumbnail_image = UIImage(data: data!)
                
                try? data?.write(to: URL(fileURLWithPath: self.getThumbnailPath()))
                
                self.thumbnail_loading = false
                
                self.delegate?.thumbnailFinished()
            }
            
            task.resume()
        }
    }
    
    //links que não tem thumbnail
    func hasThumbnail() -> Bool {
        return !["", "self", "nsfw", "default"].contains(thumbnail)
    }
}
