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
        
        override init (){
            
        }
        
        func load(completion:(assetCollection: PHAssetCollection)->()){
            loadLocalAlbun()
            loadFlickr()
            completion(assetCollection: self.assetCollection)
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

        func loadFlickr(){

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
    }
}
