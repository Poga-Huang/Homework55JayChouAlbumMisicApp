//
//  LauchScreenViewController.swift
//  Homework55JayChouAlbumMisicApp
//
//  Created by 黃柏嘉 on 2022/1/14.
//

import UIKit
import SpriteKit

private let segueIdentifier = "showAlbum"

class LauchScreenViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var myIndicator: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeMaskCoverImage()
        makeSnowEffect()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //延遲五秒
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            self.myIndicator.stopAnimating()
            self.dismiss(animated: true) {
                self.performSegue(withIdentifier: segueIdentifier, sender: nil)
            }
        }
    }
    
    func makeMaskCoverImage(){
        //mask
        let maskImageView = UIImageView(image: UIImage(named: "JayChou"))
        maskImageView.frame = CGRect(x: view.bounds.width/2-180, y: view.bounds.height/2-180, width:360, height:360)
        backgroundImageView.mask = maskImageView
        //圖片陰影
        let shadowImageView = UIImageView(image: UIImage(named: "JayChou"))
        shadowImageView.frame = CGRect(x: view.bounds.width/2-178, y: view.bounds.height/2-178, width:360, height:360)
        shadowImageView.tintColor = UIColor.white
        view.insertSubview(shadowImageView, at: 1)
    }
    func makeSnowEffect(){
        //落雪特效
        let skView = SKView(frame: view.frame)
        //加到畫面底層
        view.insertSubview(skView, at: 0)
        skView.backgroundColor = UIColor.clear
        //製作負責控制的SKScene
        let scene = SKScene(size: skView.frame.size)
        scene.backgroundColor = UIColor.clear
        skView.presentScene(scene)
        //負責效果的SKEmitterNode
        let emitterNode = SKEmitterNode(fileNamed: "backgroundSnow")
        scene.addChild(emitterNode!)
        //設定效果位置
        scene.anchorPoint = CGPoint(x: 0.5, y: 1)
    
    }
}
