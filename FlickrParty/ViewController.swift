//
//  ViewController.swift
//  FlickrParty
//
//  Created by Alberto Iglesias Gallego on 24/3/15.
//  Copyright (c) 2015 albertchurch. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    // VARIABLES
    
    var photoArray:[PhotoUnit]!
    let idPhotoCell = "FlickrPartyPhotoCell"
    
    // ACTIONS AND OUTLETS
    
    @IBAction func botonCamara(sender: AnyObject) {
        
    }
    
    @IBAction func botonGallery(sender: AnyObject) {
        
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // FUNCTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var restApiPhoto : RestApiPhotoHelper = RestApiPhotoHelper()
        dispatch_async(dispatch_get_main_queue(), {
        restApiPhoto.load({(photoArray:[PhotoUnit])->() in
            self.photoArray = photoArray
            self.collectionView.reloadData()
        })
        })
        
        self.collectionView.reloadData()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier as String! == "viewLargePhoto"){
            let controller : PhotoViewController = segue.destinationViewController as PhotoViewController
            let indexPath : NSIndexPath = self.collectionView.indexPathForCell(sender as UICollectionViewCell)!
            controller.photoUnitArray = self.photoArray
            controller.index = indexPath.item
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.hidesBarsOnTap = false
        //self.photosAsset = PHAsset.fetchAssetsInAssetCollection(self.assetCollection, options: nil)
        self.collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if self.photoArray != nil{
            return self.photoArray.count;
        }else{
            return 0
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let photoCell: PhotoThumbnailCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(idPhotoCell, forIndexPath: indexPath) as PhotoThumbnailCollectionViewCell
        
        photoCell.backgroundColor = UIColor.blackColor()
        photoCell.setThumbnailImage(self.photoArray[indexPath.item].largeImage )
        
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

