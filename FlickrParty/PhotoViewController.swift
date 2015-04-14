//
//  FlickrPartyPhotoViewController.swift
//  FlickrParty
//
//  Created by Alberto Iglesias Gallego on 24/3/15.
//  Copyright (c) 2015 albertchurch. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    // VARIABLES

    var photoUnitArray : [PhotoUnit] = []
    var index: Int = 0
    
    
    // ACTIONS AND OUTLETS
    
    @IBAction func botonBack(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func botonTrash(sender: AnyObject) {
        
    }
    
    @IBAction func botonExport(sender: AnyObject) {
        
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    // FUNCTIONS
    
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
    
    // Show photo
    func displayPhoto(){
        self.imageView.image = self.photoUnitArray[self.index].largeImage
    }

}
