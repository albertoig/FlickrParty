//
//  ApiRestPhotoAdapter.swift
//  FlickrParty
//
//  Created by Alberto Iglesias Gallego on 28/3/15.
//  Copyright (c) 2015 albertchurch. All rights reserved.
//

import Foundation

protocol ApiRestPhotoAdapter{
    
    /**var baseURL : String {get set}
    var requestURL : NSURL! {get set}
    var JSONresponse : String! {get set}
    var JSONdata : String! {get set}
    var photoList : [PhotoUnit]! {get set}
    
    
    func getJSONfromServer()
    func convertJSONResponseToJSONData()
    func convertJSONDataToPhotoList()**/
    
    /**
var baseURL : String
var requestURL : NSURL!
var JSONresponse : String!
var JSONdata : String!
var photoList : [PhotoUnit]!

//Inicialización
init(baseURL:String){
self.baseURL = baseURL
}

func getJSONfromServer(){

}
func convertJSONResponseToJSONData(){

}
func convertJSONDataToPhotoList(){

}
**/

}