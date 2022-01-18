//
//  ShowMVViewController.swift
//  Homework55JayChouAlbumMisicApp
//
//  Created by 黃柏嘉 on 2022/1/17.
//

import UIKit
import WebKit

private let youtubeAddress = "https://www.youtube.com/watch?v="

class ShowMVViewController: UIViewController,WKNavigationDelegate{
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var mvWebView: WKWebView!
    
    var mvID:String
    init?(coder:NSCoder,mvID:String){
        self.mvID = mvID
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showNavigationTitle()
        guard let url = URL(string: youtubeAddress+mvID) else {return}
        let request = URLRequest(url:url)
        mvWebView.load(request)
        mvWebView.navigationDelegate = self
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicatorView.stopAnimating()
    }

}
