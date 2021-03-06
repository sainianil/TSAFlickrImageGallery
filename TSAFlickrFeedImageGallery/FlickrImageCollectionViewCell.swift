//
//  FlickrImageCollectionViewCell.swift
//  TSAFlickrFeedImageGallery
//
//  Created by Anil Saini on 7/17/17.
//  Copyright © 2017 Anil Saini. All rights reserved.
//

import UIKit

/**
 * FlickrImageCollectionViewCell: Customized collection view cell contains UIImageView to show image.
 */

class FlickrImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var flickrImgView: UIImageView?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //set image to nil for reuse
        self.flickrImgView?.image = nil
    }
}
