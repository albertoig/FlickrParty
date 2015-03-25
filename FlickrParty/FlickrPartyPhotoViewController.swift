//
//  FlickrPartyPhotoViewController.swift
//  FlickrParty
//
//  Created by Alberto Iglesias Gallego on 24/3/15.
//  Copyright (c) 2015 albertchurch. All rights reserved.
//

import UIKit
import Photos


class FlickrPartyPhotoViewController: UIViewController {
    var assetCollection : PHAssetCollection!
    var photosAsset: PHFetchResult!
    var index: Int = 0
    
    
    @IBAction func botonBack(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func botonTrash(sender: AnyObject) {
        
    }
    
    @IBAction func botonExport(sender: AnyObject) {
        
    }
    
    @IBOutlet weak var imageView: UIImageView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.hidesBarsOnTap = true
        self.displayPhoto()
    }
    
    func displayPhoto(){
        let imageManager = PHImageManager.defaultManager()
        var ID = imageManager.requestImageForAsset(self.photosAsset[index] as PHAsset, targetSize: PHImageManagerMaximumSize, contentMode: .AspectFit, options: nil,
            resultHandler: {(result:UIImage!, info:[NSObject:AnyObject]!)in
                self.imageView.image = result
        })
    
    }

}
