//
//  FlickrJSONParser.swift
//  TSAFlickrFeedImageGallery
//
//  Created by Anil Saini on 7/18/17.
//  Copyright © 2017 Anil Saini. All rights reserved.
//

/**
 * FlickrJSONParser - This class parses the json data received from flickr feeds
 */

import UIKit

class FlickrJSONParser: NSObject {
    
    func parse(withJSON json:[String : AnyObject]) -> [FlickrImage] {
        var flickrDic = [FlickrImage]()
        let items = json["items"] as! [AnyObject]
        
        for item in items {
            let dicItem = item as? [String: AnyObject]
//            print(dicItem!)
            let feedItem = FlickrImage()
            feedItem.title = dicItem?["title"] as? String
            let m = dicItem?["media"] as? [String:String]
            feedItem.media = m?["m"]
            feedItem.author = dicItem?["author"] as? String
            feedItem.authorId = dicItem?["author_id"] as? String
            feedItem.dateTaken = dicItem?["date_taken"] as? String
            feedItem.imageDesc = dicItem?["description"] as? String
            feedItem.published = dicItem?["published"] as? String
            feedItem.link = dicItem?["link"] as? String
            feedItem.tags = dicItem?["tags"] as? String
            flickrDic.append(feedItem);
        }
        return flickrDic
    }
}
