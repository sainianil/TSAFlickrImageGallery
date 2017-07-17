//
//  FlickrImage.swift
//  TSAFlickrFeedImageGallery
//
//  Created by Anil Saini on 7/17/17.
//  Copyright © 2017 Anil Saini. All rights reserved.
//

import UIKit

class FlickrImage: NSObject {
    var title: String?
    var link: String?
    var media: String?
    var dateTaken: String?
    var imageDesc: String?
    var published: String?
    var author: String?
    var authorId: String?
    var tags: String?
    
    override init() {
        let noData = "Not available"
        self.title = noData
        self.link = noData
        self.media = noData
        self.dateTaken = noData
        self.imageDesc = noData
        self.published = noData
        self.author = noData
        self.authorId = noData
        self.tags = noData
    }
}
