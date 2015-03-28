//
//  RestApiFlickr.swift
//  FlickrParty
//
//  Created by Alberto Iglesias Gallego on 28/3/15.
//  Copyright (c) 2015 albertchurch. All rights reserved.
//

import UIKit

class RestApiFlickr {
    
    var baseURL : String!
    var requestURL : NSURL!
    var JSONresponse : String!
    var photoList : [PhotoUnit]!
    var jsonDictionary : NSDictionary!
    
    //Inicialización
    init(baseURL:String){
        self.baseURL = baseURL
    }
    
    // Just get NSData from server
    func getJSONDataFromServer(requestURL:NSURL)->NSData{
        return NSData(contentsOfURL: requestURL)!
    }

    // set NSDictionary from JSON
    func convertJSONToNSDictionary(jsonData:NSData){
        self.jsonDictionary =  NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: nil) as NSDictionary
    }
    
    // get URL image
    func URLForFlickrPhoto(photo:PhotoUnit, size:String)->String{
        var _size:String = size
        
        if _size.isEmpty{
            _size = "m"
        }
        
        return "http://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.photoID)_\(photo.secret)_\(_size).jpg"
    }

    // For search
    class func URLForSearchString (searchString:String) -> String{
        let apiKey:String = "FILL IN YOUR API KEY HERE"
        let search:String = searchString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        return "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(search)&per_page=20&format=json&nojsoncallback=1"
    }
    
    
    func convertNSDictionaryToPhotoUnitList(jsonDictionary: NSDictionary, completion:(searchString:String!, flickrPhotos:NSMutableArray!, error:NSError!)->()){
        
        let photos : NSDictionary = jsonDictionary["photos"] as NSDictionary
        let photoArray : NSArray = photos.objectForKey("photo") as NSArray
        let flickrPhotos : NSMutableArray = NSMutableArray()
        var error:NSError?
        
        for photoObject in photoArray{
            let photoDict : NSDictionary = photoObject as NSDictionary
            var photoUnit : PhotoUnit = PhotoUnit(title:photoDict.objectForKey("title") as String)
            let searchURL:String = self.URLForFlickrPhoto(photoUnit, size: "m")
            let imageData:NSData = NSData(contentsOfURL:NSURL(fileURLWithPath: searchURL)!, options: nil, error: &error)!
            let image:UIImage = UIImage(data: imageData)!
            photoUnit.thumbnail = image
            flickrPhotos.addObject(photoUnit)
        }
        
        //self.photoList = flickrPhotos
    }

}
