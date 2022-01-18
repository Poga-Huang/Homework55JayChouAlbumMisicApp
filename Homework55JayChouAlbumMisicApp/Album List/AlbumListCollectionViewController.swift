//
//  AlbumListCollectionViewController.swift
//  Homework55JayChouAlbumMisicApp
//
//  Created by 黃柏嘉 on 2022/1/15.
//

import UIKit

private let reuseIdentifier = "albumCell"

class AlbumListCollectionViewController: UICollectionViewController {
    
    //要傳遞的值
    var selectIndex:Int?
    var albumName:String?
    var albumPhoto:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    //傳值
    @IBSegueAction func showAlbumDetail(_ coder: NSCoder) -> AlbumDetailViewController? {
        guard let selectIndex = selectIndex ,let albumName = albumName,let albumPhoto = albumPhoto else {
            return AlbumDetailViewController(coder: coder)
        }
        return AlbumDetailViewController(coder: coder, selectIndex: selectIndex, albumName: albumName, albumPhoto: albumPhoto)
    }
    
    //CollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AlbumsData.data.albums.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? AlbumCollectionViewCell else{return UICollectionViewCell()}
        
        catchAlbumPhoto(indexPath:indexPath.item) { (data) in
            DispatchQueue.main.async {
                if indexPath == collectionView.indexPath(for: cell){
                    if let image = UIImage(data: data){
                        cell.updateCellContent(photo:image, albumName: AlbumsData.data.albums[indexPath.item].albumName)
                    }
                }
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? AlbumCollectionViewCell else{return}
        selectIndex = indexPath.item
        albumName = AlbumsData.data.albums[indexPath.item].albumName
        albumPhoto = cell.albumPhotoImageView.image
        performSegue(withIdentifier: "showAlbumDetail", sender: nil)
        
    }
    
    //抓圖
    func catchAlbumPhoto(indexPath:Int,completion:@escaping(Data)->()){
        guard let picURL = URL(string:AlbumsData.data.albums[indexPath].albumPicURL)else{return}
        URLSession.shared.dataTask(with: picURL) {(data,response,error)in
            if let data = data {
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        }.resume()
    }
    

}
