//
//  FilckrPartyPhotoThumbnailCollectionViewCell.swift
//  FlickrParty
//
//  Created by Alberto Iglesias Gallego on 24/3/15.
//  Copyright (c) 2015 albertchurch. All rights reserved.
//

import UIKit

class FilckrPartyPhotoThumbnailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func setThumbnailImage(thumb:UIImage){
        self.imageView.image = thumb
    }
    
}
