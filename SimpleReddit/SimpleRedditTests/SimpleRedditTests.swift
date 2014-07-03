//
//  SimpleRedditTests.swift
//  SimpleRedditTests
//
//  Created by Paulo Cesar Ferreira on 02/07/14.
//  Copyright (c) 2014 Paulo Cesar Ferreira. All rights reserved.
//

import XCTest
import SimpleReddit

class SimpleRedditTests: XCTestCase {
    
    let reddit = RedditManager();
    var waitAsyncTask = true
    
    override func setUp() {
        super.setUp()
        
        func afterTest() {
            waitAsyncTask = false
        }
        
        reddit.reloadData(afterTest)
        
        //necessário pois o sistema de testes ignora tasks assíncronas
        while waitAsyncTask {
            NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode,
                beforeDate: NSDate(timeIntervalSinceNow: 0.1))
        }
    }
    
    func testRedditHasItems() {
        XCTAssert(reddit.items?.count > 0, "items are ok")
    }
    
    func testItemsAreOk() {
        let data : LinkInfo? = reddit.dataForIndex(0)
        XCTAssertNotNil(data?.title, "data has title")
    }
    
}
