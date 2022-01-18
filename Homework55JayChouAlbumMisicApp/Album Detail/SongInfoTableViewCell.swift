//
//  SongInfoTableViewCell.swift
//  Homework55JayChouAlbumMisicApp
//
//  Created by 黃柏嘉 on 2022/1/18.
//

import UIKit

class SongInfoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var mvPhotoImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    
    func updateSongInfo(image:UIImage,name:String){
        mvPhotoImageView.image = image
        songNameLabel.text = name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
