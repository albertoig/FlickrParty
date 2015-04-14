//
//  RestApiPhotoHelper.swift
//  FlickrParty
//
//  Created by Alberto Iglesias Gallego on 10/4/15.
//  Copyright (c) 2015 albertchurch. All rights reserved.
//

import UIKit

// Subclass to manage photo rest api
class RestApiPhotoHelper : RestApiHelper{
    
    
    let idPhotoCell = "FlickrPartyPhotoCell"
    var flickrApiPhotos = RestApiBridge(photoAlbum: FlickrApi())
    var localApiPhotos = RestApiBridge(photoAlbum: LocalApi())
    var photoArray:[PhotoUnit] = []
    
    override init (){
        
    }
    
    func load(completion:(photoArray:[PhotoUnit])->()){
        NSLog("-> Start to Load Photos")
        
        loadFlickrPhotos({(photoArrayInternetAlbums:[PhotoUnit])->() in
            NSLog("---> Loaded Flirck Photos")
            self.photoArray += photoArrayInternetAlbums
            completion(photoArray: self.photoArray)
        })
        
        /**loadLocalPhotos({(photoArrayLoadLocalAlbums:[PhotoUnit])->() in
            NSLog("---> Loaded Local Photos")
            self.photoArray += photoArrayLoadLocalAlbums
            completion(photoArray: self.photoArray)
        })**/
        
        
    }
    
    func loadFlickrPhotos(completionLoadAlbum:(photoArrayLoadInternetAlbums:[PhotoUnit])->()){
        NSLog("--> Start to run Flickr Photos")
        flickrApiPhotos.run({(photoArrayRun:[PhotoUnit])->() in
            completionLoadAlbum(photoArrayLoadInternetAlbums: photoArrayRun)
        })
    }
    
    func loadLocalPhotos(completionLoadAlbum:(photoArrayLoadLocalAlbums:[PhotoUnit])->()){
        NSLog("--> Start to run Local Photos")
        localApiPhotos.run({(photoArrayRun:[PhotoUnit])->() in
            completionLoadAlbum(photoArrayLoadLocalAlbums: photoArrayRun)
        })
    }
    
    
}
