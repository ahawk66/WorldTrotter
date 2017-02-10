//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Alex Hawkins on 2/8/17.
//  Copyright © 2017 Alexander Hawkins. All rights reserved.
//

import UIKit
import WebKit


class webViewController: UIViewController{
    
    var webView: WKWebView!
    
    override func loadView() {
        
        super.viewDidLoad()
        webView = WKWebView()
        
        let myURL = URL(string: "https://www.bignerdranch.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        view = webView
    }
}
