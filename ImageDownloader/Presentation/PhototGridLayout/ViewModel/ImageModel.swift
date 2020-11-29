//
//  ImageModel.swift
//  ImageDownloader
//
//  Created by Pradip Walghude on 22/11/20.
//  Copyright © 2020 ZS Associate. All rights reserved.
//

import UIKit

struct ImageModel {

    let imageURL: String
    
    init(withPhotos photo: FlickrPhoto) {
        imageURL = photo.imageURL
    }
}
