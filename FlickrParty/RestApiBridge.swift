//
//  RestApi.swift
//  FlickrParty
//
//  Created by Alberto Iglesias Gallego on 28/3/15.
//  Copyright (c) 2015 albertchurch. All rights reserved.
//

import UIKit

//Brige Pattern
class RestApiBridge: ICallBack {
    
    var photoAlbumApi : IPhotoAlbumApi
    
    
    init(photoAlbum : IPhotoAlbumApi){
        self.photoAlbumApi = photoAlbum
    }
    
    func run(completionRun:(photoArray:[PhotoUnit])->()) {
        self.photoAlbumApi.callToGetAlbum({(completionCallToGetAlbum:[PhotoUnit])->() in
            completionRun(photoArray: completionCallToGetAlbum)
        })
    }
    
}