//
//  LinkViewController.swift
//  SimpleReddit
//
//  Created by Paulo Cesar Ferreira on 03/07/14.
//  Copyright (c) 2014 Paulo Cesar Ferreira. All rights reserved.
//

import UIKit

class LinkViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet var webview: UIWebView
    @IBOutlet var activityIndicator: UIActivityIndicatorView
    
    var linkInfo : LinkInfo?
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURLRequest(URL: NSURL(string: linkInfo?.url))
        webview.loadRequest(url)
        webview.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func webViewDidFinishLoad(webView: UIWebView!) {
        UIView.animateWithDuration(0.2, animations: {
           self.activityIndicator.alpha = 0
        })
    }
}
