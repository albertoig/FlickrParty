//
//  RestApi.swift
//  FlickrParty
//
//  Created by Alberto Iglesias Gallego on 28/3/15.
//  Copyright (c) 2015 albertchurch. All rights reserved.
//

import UIKit

// KIND OF BRIDGE PATTERN
class RestApiBridge: ICallBack {
    
    // VARIABLES
    var photoAlbumApi : IPhotoAlbumApi
    
    // INIT FUNCTION
    init(photoAlbum : IPhotoAlbumApi){
        self.photoAlbumApi = photoAlbum
    }
    
    // FUNCTIONS
    func run(completionRun:(photoArray:[PhotoUnit])->()) {
        self.photoAlbumApi.callToGetAlbum({(completionCallToGetAlbum:[PhotoUnit])->() in
            completionRun(photoArray: completionCallToGetAlbum)
        })
    }
    
}