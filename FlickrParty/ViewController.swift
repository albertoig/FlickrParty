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
//let albunName = "Flickr Album"

class ViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    /**
    ** Variables
    **/
    
    var assetCollection: PHAssetCollection!
    var photosAsset: PHFetchResult!
    var photoArray:[PhotoUnit]!
    
    /**
    ** Actions and Outlets
    **/
    
    @IBAction func botonCamara(sender: AnyObject) {
        
    }
    
    @IBAction func botonGallery(sender: AnyObject) {
        
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    /**
    ** Overrides
    **/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var restApiPhoto : RestApiHelper.RestApiPhotoHelper = RestApiHelper.RestApiPhotoHelper()
        
        restApiPhoto.load({(photoArray:[PhotoUnit],assetCollection: PHAssetCollection)->() in
            self.photoArray = photoArray
            self.assetCollection = assetCollection
            self.collectionView.reloadData()
        })
        
        var restApiPhoto2 : RestApiHelper.RestApiPhotoHelper = RestApiHelper.RestApiPhotoHelper()
        restApiPhoto2.loadLocalAlbun()
        self.assetCollection = restApiPhoto2.assetCollection

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject?) {
        if(segue.identifier as String! == "viewLargePhoto"){
            let controller : PhotoViewController = segue.destinationViewController as PhotoViewController
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
        
        let photoCell: PhotoThumbnailCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(idPhotoCell, forIndexPath: indexPath) as PhotoThumbnailCollectionViewCell
        photoCell.backgroundColor = UIColor.blackColor()

        let asset: PHAsset = self.photosAsset[indexPath.item] as PHAsset
        
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: PHImageManagerMaximumSize, contentMode: .AspectFill, options: nil,
            resultHandler: {(result:UIImage!, info:[NSObject:AnyObject]!)in
                photoCell.setThumbnailImage(result)
            })
        
        return photoCell
    }
    
    // control the minimun line spacing for each section
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 4
    }
    
    // control the minimin spacing for each section
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 1
    }
}

