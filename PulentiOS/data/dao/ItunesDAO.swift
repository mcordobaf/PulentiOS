//
//  ItunesDAO.swift
//  PulentiOS
//
//  Created by t on 10/12/19.
//  Copyright © 2019 mcordobaf. All rights reserved.
//

import UIKit

class ItunesDAO {
    
    let mainUrl:URL
    public static func getInstance() -> ItunesDAO
    {
        return ItunesDAO()
    }
    
    init() {
        self.mainUrl = URL(string: "https://itunes.apple.com/", relativeTo: nil)!
    }
    
    func searchByTerm(term:String!, pagination:Int,  listener:RequestListener)
    {
        let params = ("?term=" + term + "&mediaType=music&limit=" + String(pagination)).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let urlItunes:URL? = URL(string: "search\(params!)", relativeTo: self.mainUrl)
        
        
        let requestTask:RequestTask = RequestTask(url: urlItunes!, listener: listener)
        requestTask.executeRequest()
    }
    
    func searchSongsByAlbum(collectionId:Int, listener:RequestListener){
         let params = ("?id=" + String(collectionId) + "&entity=song").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let urlLookup:URL? = URL(string: "lookup\(params!)", relativeTo: self.mainUrl)
        
        let requestTask:RequestTask = RequestTask(url: urlLookup!, listener: listener)
        requestTask.executeRequest()
    }

    func downloadPreviewSong(url:String, listener:RequestListener){
        let requestTask:RequestTask = RequestTask(url: URL(string: url), listener: listener)
        requestTask.contentType = "media"
        requestTask.executeRequest()
    }
}
