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
    private let flickrFeedKeys = ["Title", "Link", "Media", "Date Taken", "Description", "Published", "Author", "AuthorId", "Tags"]
    
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
    
    var dateTakenAsDate: Date {
        get {
            return covertStringDateToDate(strDate: self.dateTaken!)!
        }
    }
    
    var publishedAsDate : Date {
        get {
            return covertStringDateToDate(strDate: self.published!)!
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
    
    func jsonKeys() -> [String] {
        return flickrFeedKeys
    }
    
    func jsonValue(forKey key:String) -> String {
        var value = ""
        switch key {
        case "Title":
            value = self.title!
        case "Link":
            value = self.link!
        case "Media":
            value = self.media!
        case "Date Taken":
            value = self.dateTaken!
        case "Description":
            value = self.imageDesc!
        case "Published":
            value = self.published!
        case "Author":
            value = self.author!
        case "AuthorId":
            value = self.authorId!
        case "Tags":
            value = self.tags!
        default:
            value = ""
        }
        return value
    }
    
    private func covertStringDateToDate(strDate:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" //"2017-04-27T12:17:17-08:00"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        let date = dateFormatter.date(from: strDate) //according to date format date string
        return date ?? Date()
    }
}
