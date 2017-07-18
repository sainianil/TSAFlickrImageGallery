//
//  FlickrFeedFetcher.swift
//  TSAFlickrFeedImageGallery
//
//  Created by Anil Saini on 7/18/17.
//  Copyright © 2017 Anil Saini. All rights reserved.
//

/**
 * FlickrFeedFetcher - This class request flickr server for feeds for provided url.
 */

import UIKit
import Alamofire

class FlickrFeedFetcher: NSObject {

    func requestFlickr(withFeedLink flickrLink:String, completionHandler:@escaping ([String : AnyObject]?) ->()) {
        if let url = URL(string: flickrLink) {
            Alamofire.request(url, method: .get).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let jsonDic = value as? [String : AnyObject] {
                        completionHandler(jsonDic)
                    } else {
                        completionHandler(nil)
                    }
                case .failure(let error):
                    print(error)
                    completionHandler(nil)
                }
            }
        }
    }
}
