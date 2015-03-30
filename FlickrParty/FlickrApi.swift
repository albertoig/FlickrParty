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

    // Variables
    let apiKey:String = "d47102c8725e3fced6e6dedacbaa0a3e" // My public Key api
    let userID:String = "130376528@N03" // Owner of the photos
    let albumID:String = "72157651551478351"
    let baseURL:String = "https://api.flickr.com/services/rest/"
    let methoPhotoAlbumdURL:String = "&method=flickr.photosets.getPhotos"
    let perPageURL:String = "&per_page=100"
    let returnFormat:String = "&format=json"
    var urlPatterntoGetAlbum:String!
    var result : NSDictionary!
    
    // INIT
    init(){
        self.urlPatterntoGetAlbum = self.getAlbumURL()
    }

    // Functions
    func callToGetAlbum()->[PhotoUnit]{
        self.getJSONAlbum{ (request,error) in
            self.result = request
        }
        
        return self.convertNSDictionaryToPhotoUnitList(self.result)
    }
    
    
    // MARK: Build URL Album Call - Just working with public albums
    // URL EXAMPLE : https://api.flickr.com/services/rest/?&method=flickr.photosets.getPhotos&api_key=d47102c8725e3fced6e6dedacbaa0a3e&user_id=130376528@N03&photoset_id=72157651551478351&format=json
    func getAlbumURL () -> String{
        return "\(baseURL)\(methoPhotoAlbumdURL)&api_key=\(self.apiKey)&user_id=\(userID)&photoset_id=\(albumID)\(perPageURL)\(returnFormat)"
    }

    // MARK: Return URL for one image
    func getURLForFlickrPhoto(photo:PhotoUnit, size:String)->String{
        var _size:String = size
        
        if _size.isEmpty{
            _size = "m"
        }
        
        return "http://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.photoID)_\(photo.secret)_\(_size).jpg"
    }

    
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
    
    

    func convertNSDictionaryToPhotoUnitList(jsonDictionary: NSDictionary!)->[PhotoUnit]!{

        if((jsonDictionary) != nil){
            let photos : NSDictionary = jsonDictionary["photos"] as NSDictionary
            let photoArray : NSArray = photos.objectForKey("photo") as NSArray
            let flickrPhotos : NSMutableArray = NSMutableArray()
            var error:NSError?
            
            for photoObject in photoArray{
                let photoDict : NSDictionary = photoObject as NSDictionary
                var photoUnit : PhotoUnit = PhotoUnit(title:photoDict.objectForKey("title") as String)
                let searchURL:String = self.getURLForFlickrPhoto(photoUnit, size: "m")
                let imageData:NSData = NSData(contentsOfURL:NSURL(fileURLWithPath: searchURL)!, options: nil, error: &error)!
                let image:UIImage = UIImage(data: imageData)!
                photoUnit.thumbnail = image
                flickrPhotos.addObject(photoUnit)
            }
        
            return flickrPhotos as AnyObject as [PhotoUnit]
        }else{
            return nil
        }
        
    }

}
