//
//  PhotoAlbumCallBack.swift
//  FlickrParty
//
//  Created by Alberto Iglesias Gallego on 28/3/15.
//  Copyright (c) 2015 albertchurch. All rights reserved.
//

import UIKit

protocol IPhotoAlbumApi  {
    func callToGetAlbum(completionCallToGetAlbum:(photoArray:[PhotoUnit])->())//->[PhotoUnit]
}
