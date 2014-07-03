//
//  LinkViewController.swift
//  SimpleReddit
//
//  Created by Paulo Cesar Ferreira on 03/07/14.
//  Copyright (c) 2014 Paulo Cesar Ferreira. All rights reserved.
//

import UIKit

class LinkViewController: UIViewController {

    @IBOutlet var webview: UIWebView
    var linkInfo : LinkInfo?
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURLRequest(URL: NSURL(string: linkInfo?.url))
        webview.loadRequest(url)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
