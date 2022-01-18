//
//  AlbumListBackViewController.swift
//  Homework55JayChouAlbumMisicApp
//
//  Created by 黃柏嘉 on 2022/1/15.
//

import UIKit

class AlbumListBackViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showNavigationTitle()
        
    }
    
}
extension UIViewController{
    func showNavigationTitle(){
        let titleLabel = UILabel()
        let title = "Jay Chou"
        let attributedTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont(name: "Snell Roundhand Bold", size: 35)!,NSAttributedString.Key.foregroundColor:UIColor.white])
        titleLabel.attributedText = attributedTitle
        navigationItem.titleView = titleLabel
    }
}
