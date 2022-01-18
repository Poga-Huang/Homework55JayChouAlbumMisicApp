//
//  AlbumsDataStruct.swift
//  Homework55JayChouAlbumMisicApp
//
//  Created by 黃柏嘉 on 2022/1/17.
//

import Foundation

struct Albums{
    var albums:[Album]
}
struct Album{
    var albumName:String
    var albumPicURL:String
    var albumProfileURL:String
    var songs:[Song]
}
struct Song{
    var mvID:String
}
