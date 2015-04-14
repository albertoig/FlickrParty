//
//  PhotoUnit.swift
//  FlickrParty
//
//  Created by Alberto Iglesias Gallego on 26/3/15.
//  Copyright (c) 2015 albertchurch. All rights reserved.
//

import UIKit
import Photos

class PhotoUnit: PHAsset {
    
    var thumbnail:UIImage!
    var largeImage:UIImage!
    var photoID:String!
    var farm:Int!
    var server:String!
    var secret:String!
    var title : String!
    var desc : String!

    init(title:String, photoID:String, server:String, desc:String,farm:Int, secret: String, thumbnail:UIImage,largeImage:UIImage){
        self.title = title
        self.photoID = photoID
        self.server = server
        self.desc = desc
        self.farm = farm
        self.secret = secret
    }
    
    init(title:String, photoID:String, server:String, desc:String,farm:Int, secret: String){
        self.title = title
        self.photoID = photoID
        self.server = server
        self.desc = desc
        self.farm = farm
        self.secret = secret
    }
    
}
