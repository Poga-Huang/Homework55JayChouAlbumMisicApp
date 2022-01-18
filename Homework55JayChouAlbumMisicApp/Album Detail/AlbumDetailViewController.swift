//
//  AlbumDetailViewController.swift
//  Homework55JayChouAlbumMisicApp
//
//  Created by 黃柏嘉 on 2022/1/17.
//

import UIKit
import SafariServices

private let apiKey = "AIzaSyCofc-ab2bLZBEkD7PvYJSSQXMQtGLl_7g"
private let reuseIdentifier = "mvInfoCell"
private let segueIdentifier = "showMV"

class AlbumDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var albumCoverImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var songTableView: UITableView!
    
    var ytResponseArray:[mvInfo] = []
    var ytResponseSorted:[mvInfo] = []
    var selectMVID:String?
    
    //接收值
    var selectIndex:Int
    var albumName:String
    var albumPhoto:UIImage
    init?(coder:NSCoder,selectIndex:Int,albumName:String,albumPhoto:UIImage){
        self.selectIndex = selectIndex
        self.albumName = albumName
        self.albumPhoto = albumPhoto
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumNameLabel.text = albumName
        albumCoverImageView.image = albumPhoto
        backgroundImageView.image = albumPhoto
        showNavigationTitle()
        
        catchYTApiInfo()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        //按照順序排好
        for i in 0..<ytResponseArray.count{
            for j in 0..<ytResponseArray.count{
                if i == ytResponseArray[j].mvSequence{
                    ytResponseSorted.append(ytResponseArray[j])
                }
            }
        }
        
        songTableView.reloadData()
    }
    
    @IBSegueAction func passMVID(_ coder: NSCoder) -> ShowMVViewController? {
        guard let selectMVID = selectMVID else {return nil}
        return ShowMVViewController(coder: coder, mvID: selectMVID)
    }
    
    @IBAction func lookUpAlbumProfile(_ sender: UIButton) {
        guard let url = URL(string: AlbumsData.data.albums[selectIndex].albumProfileURL) else{return}
        let controller = SFSafariViewController(url:url)
        present(controller, animated: true, completion: nil)
    }
    
    //TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlbumsData.data.albums[selectIndex].songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SongInfoTableViewCell else{return UITableViewCell()}
        if ytResponseSorted.count != 0{
            catchPhoto(url: ytResponseSorted[indexPath.row].mvPicURL) { (data) in
                if indexPath == tableView.indexPath(for: cell){
                DispatchQueue.main.async {
                   cell.mvPhotoImageView.image = UIImage(data: data)
                }
            }
        }
            cell.songNameLabel.text = self.ytResponseSorted[indexPath.row].mvTitle
        }else{
            cell.songNameLabel.text = "讀取中..."
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectMVID = AlbumsData.data.albums[selectIndex].songs[indexPath.row].mvID
        performSegue(withIdentifier: segueIdentifier, sender: nil)
        
    }
    
    //抓JSON檔案
    func catchYTApiInfo(){
        for i in 0..<AlbumsData.data.albums[selectIndex].songs.count{
            guard let url = URL(string: "https://www.googleapis.com/youtube/v3/videos?id=\(AlbumsData.data.albums[selectIndex].songs[i].mvID)&key=\(apiKey)&part=snippet") else{return }
            URLSession.shared.dataTask(with: url) {(data,response,error)in
                let decoder = JSONDecoder()
                if let data = data {
                    do{
                        let ytResponse = try decoder.decode(YTResponse.self, from: data)
                        self.ytResponseArray.append(mvInfo(mvTitle: ytResponse.items[0].snippet.title, mvPicURL: ytResponse.items[0].snippet.thumbnails.high.url, mvSequence: i))
                    }catch{
                        print(error)
                    }
                }
            }.resume()
        }
      
    }
//    //抓圖
    func catchPhoto(url:String,completion:@escaping(Data)->()){
        guard let picUrl = URL(string: url) else {return}
        URLSession.shared.dataTask(with: picUrl) {(data,response,error)in
        guard let data = data else {return}
        DispatchQueue.main.async {
            completion(data)
        }
    }.resume()
}

}
