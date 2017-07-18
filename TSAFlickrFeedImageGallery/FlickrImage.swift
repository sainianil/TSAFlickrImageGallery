//
//  FlickrImage.swift
//  TSAFlickrFeedImageGallery
//
//  Created by Anil Saini on 7/17/17.
//  Copyright © 2017 Anil Saini. All rights reserved.
//

/**
 * FlickrImage: Model class to have Flickr public feed information.
 */

import UIKit

class FlickrImage: NSObject {
    var title: String? {
        didSet {
            if title == nil {
                title = ""
            }
        }
    }
    var link: String? {
        didSet {
            if link == nil {
                link = ""
            }
        }
    }
    var media: String? {
        didSet {
            if media == nil {
                media = ""
            }
        }
    }
    var dateTaken: String? {
        didSet {
            if dateTaken == nil {
                dateTaken = ""
            }
        }
    }
    var imageDesc: String? {
        didSet {
            if imageDesc == nil {
                imageDesc = ""
            }
        }
    }
    var published: String? {
        didSet {
            if published == nil {
                published = ""
            }
        }
    }
    var author: String? {
        didSet {
            if author == nil {
                author = ""
            }
        }
    }
    var authorId: String? {
        didSet {
            if authorId == nil {
                authorId = ""
            }
        }
    }
    var tags: String? {
        didSet {
            if tags == nil {
                tags = ""
            }
        }
    }
    
    override init() {
        self.title = ""
        self.link = ""
        self.media = ""
        self.dateTaken = ""
        self.imageDesc = ""
        self.published = ""
        self.author = ""
        self.authorId = ""
        self.tags = ""
    }
}
