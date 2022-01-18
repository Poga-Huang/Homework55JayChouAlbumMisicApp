//
//  YouTubeResponse.swift
//  Homework55JayChouAlbumMisicApp
//
//  Created by 黃柏嘉 on 2022/1/18.
//

import Foundation
struct YTResponse:Codable{
    var items:[Item]
    struct Item:Codable{
        var snippet:Snippet
        struct Snippet:Codable{
            var title:String
            var thumbnails:Thumbnails
            struct Thumbnails:Codable{
                var high:High
                struct High:Codable{
                    var url:String
                }
            }
        }
    }
}

struct mvInfo{
    var mvTitle:String
    var mvPicURL:String
    var mvSequence:Int
}
