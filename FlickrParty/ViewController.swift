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
    var restApiPhoto : RestApiPhotoHelper = RestApiPhotoHelper()
    var refreshControl:UIRefreshControl!
    
    // ACTIONS AND OUTLETS
    
    @IBAction func botonCamara(sender: AnyObject) {
        
    }
    
    @IBAction func botonGallery(sender: AnyObject) {
        
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // FUNCTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Necesary to pull refresh
        self.collectionView.alwaysBounceVertical = true;
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.collectionView.addSubview(refreshControl)
        
        //First load
        self.loadingIndicator.startAnimating()
        self.loadPhotos()

    }

    func refresh(sender: AnyObject){
        self.loadPhotos()
    }

    func loadPhotos(){
        //Load with rest Api Bridge
        dispatch_async(dispatch_get_main_queue(), {
            self.restApiPhoto.load({(photoArray:[PhotoUnit])->() in
                self.photoArray = photoArray
                self.collectionView.reloadData()
                
                //stop to load
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.hidden = true
                self.refreshControl.endRefreshing()
            })
        })
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
        return 1
    }
    
    // control the minimin spacing for each section
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 1
    }
}

