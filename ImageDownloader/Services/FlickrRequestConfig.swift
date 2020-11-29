//
//  FlickrRequestConfig.swift
//  ImageDownloader
//
//  Created by Pradip Walghude on 22/11/20.
//  Copyright © 2020 ZS Associate. All rights reserved.
//
import UIKit

enum FlickrRequestConfig {
    
    case searchRequest(String, Int)
    
    var value: Request? {
        
        switch self {
            
        case .searchRequest(let searchText, let pageNo):
            let urlString = String(format: FlickrConstants.searchURL, searchText, pageNo)
            let reqConfig = Request.init(requestMethod: .get, urlString: urlString)
            return reqConfig
        }
    }
}
