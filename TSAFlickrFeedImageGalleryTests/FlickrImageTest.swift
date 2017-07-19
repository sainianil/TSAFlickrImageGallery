//
//  FlickrImageTest.swift
//  TSAFlickrFeedImageGallery
//
//  Created by Anil Saini on 7/17/17.
//  Copyright © 2017 Anil Saini. All rights reserved.
//

import XCTest
@testable import TSAFlickrFeedImageGallery

class FlickrImageTest: XCTestCase {
    var flickrImg:FlickrImage!
    
    override func setUp() {
        super.setUp()
        flickrImg = FlickrImage()
    }
    
    override func tearDown() {
        flickrImg = nil
        super.tearDown()
    }
    
    func testDefaultValues() {
        let defaultValue = ""
        XCTAssertEqual(flickrImg.title!, defaultValue, "Wrong default value of title")
        XCTAssertEqual(flickrImg.link!, defaultValue, "Wrong default value of link")
        XCTAssertEqual(flickrImg.media!, defaultValue, "Wrong default value of media")
        XCTAssertEqual(flickrImg.dateTaken!, defaultValue, "Wrong default value of dateTaken")
        XCTAssertEqual(flickrImg.imageDesc!, defaultValue, "Wrong default value of imageDesc")
        XCTAssertEqual(flickrImg.published!, defaultValue, "Wrong default value of published")
        XCTAssertEqual(flickrImg.author!, defaultValue, "Wrong default value of author")
        XCTAssertEqual(flickrImg.authorId!, defaultValue, "Wrong default value of authorId")
        XCTAssertEqual(flickrImg.tags!, defaultValue, "Wrong default value of tags")
    }
    
    func testFlickrFeedWithSomeValue() {
        
        let title = "In the interest of additional quality millage for the week, I figured a nice 8k warm-up before our weekly social 5k would be a good start, and the views did not disappoint. #helderbergtrails #running #runner #trailrun #stravaphoto #nature #fun #southafric"
        flickrImg.title = title
        XCTAssertEqual(flickrImg.title!, title, "Wrong value of title")
        
        let media = "http://flickr.com/photos/358014443767a5cbbd09"
        flickrImg.media = media
        XCTAssertEqual(flickrImg.media!, media, "Wrong value of media")
        
        let link = "http://farm5.staticflickr.com/4290/35801444376_e7a5cbbd09_m.jpg"
        flickrImg.link = link
        XCTAssertEqual(flickrImg.link!, link, "Wrong value of link")
        
        let date_taken = "2017-07-10T20:11:30-08:00"
        flickrImg.dateTaken = date_taken
        XCTAssertEqual(flickrImg.dateTaken!, date_taken, "Wrong value of dateTaken")
        
        let description = "Description"
        flickrImg.imageDesc = description
        XCTAssertEqual(flickrImg.imageDesc!, description, "Wrong value of imageDesc")
        
        let published = "2017-07-10T18:11:30Z"
        flickrImg.published = published
        XCTAssertEqual(flickrImg.published!, published, "Wrong value of published")
        
        let author = "nobody@flickr.com (\"Reme Le Hane\")"
        flickrImg.author = author
        XCTAssertEqual(flickrImg.author!, author, "Wrong value of author")
        
        let author_id = "85994282@N07"
        flickrImg.authorId = author_id
        XCTAssertEqual(flickrImg.authorId!, author_id, "Wrong value of authorId")
        
        let tags = "in interest additional quality millage for week i figured nice 8k warmup before our weekly social 5k would be good start views did disappoint helderbergtrails running runner trailrun stravaphoto nature fun southafrica tomtom tomtomadventurer fitness trails outdoorsports stravarun runsa runninglife sauconyperegrine saucony resultsstarthere teamspca capespca ctmarathon peace trail run this september if you like support fundraising project great cause please checkout link bio any much appreciated d"
        flickrImg.tags = tags
        XCTAssertEqual(flickrImg.tags!, tags, "Wrong value of tags")
    }
    
    func testFlickrFeedForNil() {
        flickrImg.title = nil
        XCTAssertNotNil(flickrImg.title!, "title is nil")
        flickrImg.link = nil
        XCTAssertNotNil(flickrImg.link!, "link is nil")
        flickrImg.media = nil
        XCTAssertNotNil(flickrImg.media!, "media is nil")
        flickrImg.dateTaken = nil
        XCTAssertNotNil(flickrImg.dateTaken!, "dateTaken is nil")
        flickrImg.imageDesc = nil
        XCTAssertNotNil(flickrImg.imageDesc!, "imageDesc is nil")
        flickrImg.published = nil
        XCTAssertNotNil(flickrImg.published!, "published is nil")
        flickrImg.author = nil
        XCTAssertNotNil(flickrImg.author!, "author is nil")
        flickrImg.authorId = nil
        XCTAssertNotNil(flickrImg.authorId!, "authorId is nil")
        flickrImg.tags = nil
        XCTAssertNotNil(flickrImg.tags!, "tags is nil")
    }
    
    func testFlickrJSONKeys() {
        let flickrFeedKeys = ["Title", "Link", "Media", "Date Taken", "Description", "Published", "Author", "AuthorId", "Tags"]
        XCTAssertEqual(flickrImg.jsonKeys(), flickrFeedKeys, "Keys are not matched!")
    }
    
    func testjsonValueForKey() {
        let flickrFeedKeys = flickrImg.jsonKeys()
        
        flickrImg.title = "In the interest of additional quality millage for the week, I figured a nice 8k warm-up before our weekly social 5k would be a good start, and the views did not disappoint. #helderbergtrails #running #runner #trailrun #stravaphoto #nature #fun #southafric"
        XCTAssertEqual(flickrImg.title!, flickrImg.jsonValue(forKey: flickrFeedKeys[0]), "Wrong value of title")
        
        flickrImg.link = "http://farm5.staticflickr.com/4290/35801444376_e7a5cbbd09_m.jpg"
        XCTAssertEqual(flickrImg.link!, flickrImg.jsonValue(forKey: flickrFeedKeys[1]), "Wrong value of link")
        
        flickrImg.media = "http://flickr.com/photos/358014443767a5cbbd09"
        XCTAssertEqual(flickrImg.media!, flickrImg.jsonValue(forKey: flickrFeedKeys[2]), "Wrong value of media")
        
        flickrImg.dateTaken = "2017-07-10T20:11:30-08:00"
        XCTAssertEqual(flickrImg.dateTaken!, flickrImg.jsonValue(forKey: flickrFeedKeys[3]), "Wrong value of dateTaken")
        
        let description = "Description"
        flickrImg.imageDesc = description
        XCTAssertEqual(flickrImg.imageDesc!, flickrImg.jsonValue(forKey: flickrFeedKeys[4]), "Wrong value of imageDesc")
        
        let published = "2017-07-10T18:11:30Z"
        flickrImg.published = published
        XCTAssertEqual(flickrImg.published!, flickrImg.jsonValue(forKey: flickrFeedKeys[5]), "Wrong value of published")
        
        let author = "nobody@flickr.com (\"Reme Le Hane\")"
        flickrImg.author = author
        XCTAssertEqual(flickrImg.author!, flickrImg.jsonValue(forKey: flickrFeedKeys[6]), "Wrong value of author")
        
        let author_id = "85994282@N07"
        flickrImg.authorId = author_id
        XCTAssertEqual(flickrImg.authorId!, flickrImg.jsonValue(forKey: flickrFeedKeys[7]), "Wrong value of authorId")
        
        let tags = "in interest additional quality millage for week i figured nice 8k warmup before our weekly social 5k would be good start views did disappoint helderbergtrails running runner trailrun stravaphoto nature fun southafrica tomtom tomtomadventurer fitness trails outdoorsports stravarun runsa runninglife sauconyperegrine saucony resultsstarthere teamspca capespca ctmarathon peace trail run this september if you like support fundraising project great cause please checkout link bio any much appreciated d"
        flickrImg.tags = tags
        XCTAssertEqual(flickrImg.tags!, flickrImg.jsonValue(forKey: flickrFeedKeys[8]), "Wrong value of tags")
    }
    
   /* func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }*/
    
}
