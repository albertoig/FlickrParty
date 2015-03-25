//
//  ViewController.swift
//  FlickrParty
//
//  Created by Alberto Iglesias Gallego on 24/3/15.
//  Copyright (c) 2015 albertchurch. All rights reserved.
//

import UIKit
import Photos

let idPhotoCell = "FlickrPartyPhotoCell"
let albunName = "Flickr Album"

class ViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    var assetCollection: PHAssetCollection!
    var photosAsset: PHFetchResult!
    var albunFound: Bool = false
    
    
    @IBAction func botonCamara(sender: AnyObject) {
        
    }
    
    @IBAction func botonGallery(sender: AnyObject) {
        
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let options = PHFetchOptions()
        options.predicate = NSPredicate(format:"title = %@" , albunName)
        let collection = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: options)
        
        self.albunFound = true
        //Check if the albun exist
        if(collection.firstObject != nil){
            self.assetCollection = collection.firstObject as PHAssetCollection
        }else{
            //If not, create the folder
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                //add
                let request = PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle(albunName)
                
                },
                completionHandler: {(success:Bool, error:NSError!)in
                    //Do something if error....
                    if(!success){
                        self.albunFound = false
                    }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject?) {
        if(segue.identifier as String! == "viewLargePhoto"){
            let controller : FlickrPartyPhotoViewController = segue.destinationViewController as FlickrPartyPhotoViewController
            let indexPath : NSIndexPath = self.collectionView.indexPathForCell(sender as UICollectionViewCell)!
            controller.photosAsset = self.photosAsset
            controller.assetCollection = self.assetCollection
            controller.index = indexPath.item
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.hidesBarsOnTap = false
        self.photosAsset = PHAsset.fetchAssetsInAssetCollection(self.assetCollection, options: nil)
        self.collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if self.photosAsset != nil{
            return self.photosAsset.count;
        }else{
            return 0
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let photoCell: FilckrPartyPhotoThumbnailCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(idPhotoCell, forIndexPath: indexPath) as FilckrPartyPhotoThumbnailCollectionViewCell
        
        photoCell.backgroundColor = UIColor.blackColor()
        
        let asset: PHAsset = self.photosAsset[indexPath.item] as PHAsset
        
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: PHImageManagerMaximumSize, contentMode: .AspectFill, options: nil,
            resultHandler: {(result:UIImage!, info:[NSObject:AnyObject]!)in
                photoCell.setThumbnailImage(result)
            })
        
        return photoCell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 1
    }
}

