//
//  RestApiController.swift
//  FlickrParty
//
//  Created by Alberto Iglesias Gallego on 28/3/15.
//  Copyright (c) 2015 albertchurch. All rights reserved.
//

import UIKit
import Photos

class RestApiHelper: NSObject {

    
    
    // Subclass to manage photo rest api
    class RestApiPhotoHelper : RestApiHelper{

        var assetCollection: PHAssetCollection!
        var photosAsset: PHFetchResult!
        var albunFound : Bool = false
        let idPhotoCell = "FlickrPartyPhotoCell"
        let albunName = "Flickr Album"
        var restApiBridge = RestApiBridge(photoAlbum: FlickrApi())
        var photoArray:[PhotoUnit]!
        
        override init (){
            
        }
        
        func load(completion:(photoArray:[PhotoUnit],assetCollection: PHAssetCollection)->()){
            loadLocalAlbun()
            loadInternetAlbums({(photoArrayInternetAlbums:[PhotoUnit])->() in
                completion(photoArray: photoArrayInternetAlbums,assetCollection:self.assetCollection)
                
            })
            
        }
        
        func loadLocalAlbun(){

            // Load options like the title
            let options = PHFetchOptions()
            options.predicate = NSPredicate(format:"title = %@" , albunName)
            
            let collection = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: options)
            
            self.albunFound = false
            
            //Check if the albun exist
            if(collection.firstObject != nil){
                self.albunFound = true
                self.assetCollection = collection.firstObject as PHAssetCollection
            
            }else{
                //If not, create the folder
                createNewAlbum()
            }
        }

        func loadInternetAlbums(completionLoadAlbum:(photoArrayLoadInternetAlbums:[PhotoUnit])->()){
            restApiBridge.run({(photoArrayRun:[PhotoUnit])->() in
                completionLoadAlbum(photoArrayLoadInternetAlbums: photoArrayRun)
            })
        }
        
        func createNewAlbum(){
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                //add
                let request = PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle(self.albunName)
                },
                completionHandler: {(success:Bool, error:NSError!)in
                    //Do something if error....
                    if(!success){
                        self.albunFound = false
                    }
            })
        }
        
        func get(){
        

        }
    }
}
