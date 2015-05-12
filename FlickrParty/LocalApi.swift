//
//  LocalApi.swift
//  FlickrParty
//
//  Created by Alberto Iglesias Gallego on 10/4/15.
//  Copyright (c) 2015 albertchurch. All rights reserved.
//

import UIKit
import Photos

class LocalApi: IPhotoAlbumApi {
    
    var photoArray : [PhotoUnit] = []
    var assetCollection: PHAssetCollection!
    var photosAsset: PHFetchResult!
    var albunFound : Bool = false
    let albunName = "Flickr Album"

    init(){
        
    }
    
    // Functions
    func callToGetAlbum(completionCallToGetAlbum:(photoArray:[PhotoUnit])->()){
        self.getAlbum()
        self.convertToPhotoArray({(completionCallToConvertAlbum:())->() in
            completionCallToGetAlbum(photoArray: self.photoArray)
        })
    }

    internal func convertToPhotoArray(completionCallToConvertAlbum:()->()) {
        
        self.photosAsset = PHAsset.fetchAssetsInAssetCollection(self.assetCollection, options: nil)
        
        let photosAssetCount:Int = self.photosAsset.count - 1
        
        for counter in 0...photosAssetCount {
            
            let asset: PHAsset = self.photosAsset[counter] as! PHAsset

            
            //dispatch_async(dispatch_get_main_queue(), {
                var ID = PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.AspectFill, options: PHImageRequestOptions(),
                resultHandler: {(result, info)in

                    let photoUnit : PhotoUnit = PhotoUnit(title: "Local",photoID: "Local",server: "Local",desc: "Local",farm: 1,secret: "Local",thumbnail: result,largeImage: result)
                    self.photoArray.append(photoUnit)
                    if counter == photosAssetCount {
                        completionCallToConvertAlbum()
                    }

                })

            //})
        }
    }
    
    // MARK: Just create a new Album
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
    
    
    func getAlbum(){
        
        // Load options like the title
        let options = PHFetchOptions()
        options.predicate = NSPredicate(format:"title = %@" , albunName)
        
        let collection = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: options)
        
        self.albunFound = false
        
        //Check if the albun exist
        if(collection.firstObject != nil){
            self.albunFound = true
            self.assetCollection = collection.firstObject as! PHAssetCollection
            
        }else{
            //If not, create the folder
            createNewAlbum()
            // MARK: Could be fine to implement a default photo or select Album
            
        }
    }
    
}
