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
        
        func afterTest(_ success: Bool) {
            waitAsyncTask = false
        }
        
        reddit.retrieveLinks(afterTest)
        
        //necessário pois o sistema de testes ignora tasks assíncronas
        while waitAsyncTask {
            RunLoop.current.run(mode: RunLoopMode.defaultRunLoopMode,
                before: Date(timeIntervalSinceNow: 0.1))
        }
    }
    
    func testRedditHasItems() {
        XCTAssert((reddit.items?.count)! > 0, "items are ok")
    }
    
    func testItemsAreOk() {
        let data : LinkInfo? = reddit.linkInfoForIndex(0)
        XCTAssertNotNil(data?.title, "data has title")
    }
    
    func testImageLoadSpeed() {
        measure({
            let _ : LinkInfo? = self.reddit.linkInfoForIndex(0)
        })
    }
    
}
