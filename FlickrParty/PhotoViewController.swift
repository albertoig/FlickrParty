//
//  FlickrPartyPhotoViewController.swift
//  FlickrParty
//
//  Created by Alberto Iglesias Gallego on 24/3/15.
//  Copyright (c) 2015 albertchurch. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

   
    var photo : PhotoUnit = nil
    var index: Int = 0
    
    @IBAction func botonBack(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func botonTrash(sender: AnyObject) {
        
    }
    
    @IBAction func botonExport(sender: AnyObject) {
        
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(animated: Bool) {
        //Hide when tap on out screen
        self.navigationController?.hidesBarsOnTap = true
        self.display()
    }
    
    func display(){
        self.imageView.image =  photo.largeImage
        self.textView.text = photo.desc
    }

}
