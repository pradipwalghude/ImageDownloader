//
//  FlickrPhoto.swift
//  ImageDownloader
//
//  Created by Pradip Walghude on 22/11/20.
//  Copyright © 2020 ZS Associate. All rights reserved.
//

import UIKit

struct FlickrPhoto: Codable {
    
    let farm : Int
    let id : String
    
    let isfamily : Int
    let isfriend : Int
    let ispublic : Int
    
    let owner: String
    let secret : String
    let server : String
    let title: String
    
    var imageURL: String {
        let urlString = String(format: FlickrConstants.imageURL, farm, server, id, secret)
        return urlString
    }
}
