//
//  FlickrJSONParserTest.swift
//  TSAFlickrFeedImageGallery
//
//  Created by Anil Saini on 7/19/17.
//  Copyright © 2017 Anil Saini. All rights reserved.
//

import XCTest

@testable import TSAFlickrFeedImageGallery

class FlickrJSONParserTest: XCTestCase {
    var flckrJSONParser: FlickrJSONParser?
    
    override func setUp() {
        super.setUp()
        flckrJSONParser = FlickrJSONParser()
    }
    
    override func tearDown() {
        flckrJSONParser = nil
        super.tearDown()
    }
    
    func testJSONParsing() {
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
