//
//  AlbumCollectionViewCell.swift
//  Homework55JayChouAlbumMisicApp
//
//  Created by 黃柏嘉 on 2022/1/17.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var albumPhotoImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var AlbumPhotoWidth: NSLayoutConstraint!
    
    
    func updateCellContent(photo:UIImage,albumName:String){
        albumPhotoImageView.image = photo
        albumNameLabel.text = albumName
    }
    
    override func awakeFromNib() {
        AlbumPhotoWidth.constant = floor(Double((UIScreen.main.bounds.width-120)/2))
    }
}
