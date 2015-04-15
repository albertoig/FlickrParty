//
//  FlickrApi.swift
//  FlickrParty
//
//  Created by Alberto Iglesias Gallego on 29/3/15.
//  Copyright (c) 2015 albertchurch. All rights reserved.
//

import UIKit
import AlamoFire

class FlickrApi : IPhotoAlbumApi {

    //Constants
    
    // Variables
    private let apiKey:String = "d47102c8725e3fced6e6dedacbaa0a3e" // My public Key api
    private let userID:String = "130376528@N03" // Owner of the photos
    private let albumID:String = "72157651551478351"
    private let baseURL:String = "https://api.flickr.com/services/rest/"
    private var result : NSDictionary!
    internal var photoArray : [PhotoUnit] = []

    
    /**
s	cuadrado pequeño 75x75
    q	large square 150x150
    t	imagen en miniatura, 100 en el lado más largo
    m	pequeño, 240 en el lado más largo
    n	small, 320 on longest side
    -	mediano, 500 en el lado más largo
    z	mediano 640, 640 en el lado más largo
    c	tamaño mediano 800, 800 en el lado más largo†
    b	grande, 1024 en el lado más largo*
    h	grande de 1600, 1600 del lado más largo†
    k	grande de 2048, 2048 del lado más largo†
    o	imagen original, ya sea jpg, gif o png, según el formato de origen
**/

    
    // INIT
    init(){

    }

    // Functions
    func callToGetAlbum(completionCallToGetAlbum:(photoArray:[PhotoUnit])->()){
        self.getJSONAlbum{ (request,error) in
            
            if(error == nil){
                self.result = request
            
                //self.convertToPhotoArray()
                self.convertToPhotoArray({(completionCallToConvertAlbumInPhotoArray:())->() in
                    completionCallToGetAlbum(photoArray: self.photoArray)
                })
            }
            
        }
    }
    
    // MARK: Call to get JSON
    func getJSONAlbum(completionHandler: (NSDictionary?, NSError?) -> ()) -> (){
        
        Alamofire.request(.GET, self.baseURL, parameters: self.getParameters())
            .responseJSON{ (request, response, JSON, error) in

                if(error == nil){
                    println(JSON)
                    completionHandler(JSON as? NSDictionary,error)
                } else {
                    println(error)
                    completionHandler(nil,error)
                }
            }
    }

    // MARK: Parameters to call API Flickr with Alamofire
    func getParameters()->[String:String]{
        let parameters = [
            "api_key": self.apiKey,
            "user_id": self.userID,
            "photoset_id": self.albumID,
            "method" : "flickr.photosets.getPhotos",
            "format":"json",
            "nojsoncallback":"1"
        ]
        return parameters
    }

    func convertToPhotoArray(completionCallToConvertAlbumInPhotoArray:()->()){
        self.photoArray = self.convertNSDictionaryToPhotoUnitArray()
        completionCallToConvertAlbumInPhotoArray()
    }
    
    // MARK: Convert NSDictionary to photolist Array
    func convertNSDictionaryToPhotoUnitArray()->[PhotoUnit]!{

        let jsonDictionary : NSDictionary! = self.result
        
        if((jsonDictionary) != nil){
            let photos : NSDictionary = jsonDictionary["photoset"] as NSDictionary
            let photoArray : NSArray = photos.objectForKey("photo") as NSArray
            let flickrPhotos : NSMutableArray = NSMutableArray()
            
            
            for photoObject in photoArray{
                let photoDict : NSDictionary = photoObject as NSDictionary
                
                var photoUnit : PhotoUnit = PhotoUnit(title:photoDict.objectForKey("title") as String,
                                                      photoID:photoDict.objectForKey("id") as String,
                                                      server:photoDict.objectForKey("server") as String,
                                                      desc:photoDict.objectForKey("title") as String,
                                                      farm:photoDict.objectForKey("farm") as Int,
                                                      secret:photoDict.objectForKey("secret") as String)
                
                photoUnit.thumbnail = self.getImageFromURLWithSpecificSize(photoUnit,size: "m")
                photoUnit.largeImage = self.getImageFromURLWithSpecificSize(photoUnit,size: "n")
                
                flickrPhotos.addObject(photoUnit)
            }
        
            return flickrPhotos as AnyObject as [PhotoUnit]
        }else{
            return nil
        }
        
    }
    
    
    // MARK: Return URL for one image
    func getURLForFlickrPhoto(photo:PhotoUnit, size:String)->String{
        var _size:String = size
        
        if _size.isEmpty{
            _size = "m"
        }
        
        return "http://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.photoID)_\(photo.secret)_\(_size).jpg"
    }
    
    // MARK: Return a specific Image From URL
    func getImageFromURLWithSpecificSize(photo:PhotoUnit,size:String)->UIImage!{
        
        var error:NSError?
        // URL where we get the image with a specific size
        let searchURL:String = self.getURLForFlickrPhoto(photo, size: size)
        
        // Convert URL Image to UIImage
        let imageData:NSData = NSData(contentsOfURL:NSURL(string: searchURL)!, options: nil, error: &error)!
        let image:UIImage = UIImage(data: imageData)!
        
        if(error != nil){
            return nil
        }
        
        return image
    }
    
}
