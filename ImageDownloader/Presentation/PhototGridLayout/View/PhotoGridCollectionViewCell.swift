//
//  PhotoGridCollectionViewCell.swift
//  ImageDownloader
//
//  Created by Pradip Walghude on 22/11/20.
//  Copyright © 2020 ZS Associate. All rights reserved.
//

import UIKit

class PhotoGridCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    static let nibName = "PhotoGridCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
         super.prepareForReuse()
         imageView.layer.removeAllAnimations()
        imageView.image = nil
    }
    
    var model: ImageModel? {
        didSet {
            if let model = model {
                imageView.image = UIImage(named: "placeholder")
                imageView.downloadImage(model.imageURL)
            }
        }
    }
}
