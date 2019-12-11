//
//  RequestTask.swift
//  PulentiOS
//
//  Created by t on 10/12/19.
//  Copyright © 2019 mcordobaf. All rights reserved.
//

import UIKit

class RequestTask: NSObject {
    
    var url:URL?
    private var cachePolicy:URLRequest.CachePolicy? = URLRequest.CachePolicy.returnCacheDataElseLoad
    private var listener:RequestListener!
    var contentType:String = "application/json"
    
    init(url:URL!, listener:RequestListener!) {
        self.url = url
        self.listener = listener
        
    }
    
    init(url:URL!, listener:RequestListener!,
        cachePolicy:URLRequest.CachePolicy?) {
        self.url = url
        self.listener = listener
        self.cachePolicy = cachePolicy
    }
    
    func executeRequest(){
        if (url != nil){
            let urlRequest = URLRequest(url: url!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: TimeInterval(10000))
            
            let task = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
                if (data != nil && response != nil && self.listener != nil)
                {
                    if(self.contentType == "media"){
                        self.listener.previewSongDownloaded?(data: data)
                    }else{
                        self.listener.respond(data: data)
                    }
                }
                else {
                    self.listener.error(error: error!)
                }
            }
            task.resume()
        }
    }
}

protocol RequestListener : RequestListenerImage{
    func respond(data:Data?)
    func error(error:Error)
}

@objc protocol RequestListenerImage {
    @objc optional func previewSongDownloaded(data:Data?)
    
}
