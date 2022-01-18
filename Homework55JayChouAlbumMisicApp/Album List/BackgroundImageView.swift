//
//  BackgroundImageView.swift
//  Homework55JayChouAlbumMisicApp
//
//  Created by 黃柏嘉 on 2022/1/15.
//

import UIKit

class BackgroundImageView: UIImageView {
    
    //Timer
    var timer:Timer?
    //顏色Array
    let colorArray:[UIColor] = [UIColor.white,UIColor.systemRed,UIColor.systemOrange,UIColor.systemYellow,UIColor.systemGreen,UIColor.systemBlue,UIColor.systemTeal,UIColor.systemPurple]
    var colorIndex = 0{
        didSet{
            self.tintColor = colorArray[colorIndex]
        }
    }
    
    //旋轉
    func rotate(){
        UIView.transition(with: self, duration: 2, options:.transitionFlipFromRight, animations: nil, completion: nil)
        
        guard colorIndex < colorArray.count-1 else{
            return colorIndex = 0
        }
        colorIndex += 1
    }
    
    //排版完開始計時器
    override func awakeFromNib() {
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(rotateImage), userInfo: nil, repeats: true)
    }
    //執行方法
    @objc func rotateImage(){
        rotate()
    }
    
    
}
