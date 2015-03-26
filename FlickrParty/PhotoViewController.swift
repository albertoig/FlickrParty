//
//  FlickrPartyPhotoViewController.swift
//  FlickrParty
//
//  Created by Alberto Iglesias Gallego on 24/3/15.
//  Copyright (c) 2015 albertchurch. All rights reserved.
//

import UIKit
import Photos


class PhotoViewController: UIViewController {
    
    var assetCollection : PHAssetCollection!
    var photosAsset: PHFetchResult!
    var index: Int = 0
    
    /**
    ** Actions and Outlets
    **/
    
    @IBAction func botonBack(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func botonTrash(sender: AnyObject) {
        
    }
    
    @IBAction func botonExport(sender: AnyObject) {
        
    }
    
    @IBOutlet weak var imageView: UIImageView!

    
    /**
    ** Overrides
    **/
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(animated: Bool) {
        //Hide when tap on out screen
        self.navigationController?.hidesBarsOnTap = true
        self.displayPhoto()
    }
    
    /**
    ** Adtional functions
    **/
    
    //Show photo
    func displayPhoto(){
        let imageManager = PHImageManager.defaultManager()
        var ID = imageManager.requestImageForAsset(self.photosAsset[index] as PHAsset, targetSize: PHImageManagerMaximumSize, contentMode: .AspectFit, options: nil,
            resultHandler: {(result:UIImage!, info:[NSObject:AnyObject]!)in
                self.imageView.image = result
        })
    }

}
