//
//  FlickrConstants.swift
//  ImageDownloader
//
//  Created by Pradip Walghude on 22/11/20.
//  Copyright © 2020 ZS Associate. All rights reserved.
//

import UIKit

enum Result <T>{
    case Success(T)
    case Failure(String)
    case Error(String)
}
