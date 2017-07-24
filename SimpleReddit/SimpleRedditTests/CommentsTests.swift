//
//  CommentsTests.swift
//  SimpleReddit
//
//  Created by Paulo Cesar Ferreira on 04/07/14.
//  Copyright (c) 2014 Paulo Cesar Ferreira. All rights reserved.
//

import XCTest
import SimpleReddit

class CommentsTests: XCTestCase {

    let reddit = RedditManager();
    var waitAsyncTask = true
    
    override func setUp() {
        super.setUp()
        
        func afterTest(_ success: Bool) {
            waitAsyncTask = false
        }
        
        reddit.retrieveCommentsForId("291oo0", onResult: afterTest)
        
        //necessário pois o sistema de testes ignora tasks assíncronas
        while waitAsyncTask {
            RunLoop.current.run(mode: RunLoopMode.defaultRunLoopMode,
                before: Date(timeIntervalSinceNow: 0.1))
        }
    }
    
    func testHasComments() {
        XCTAssert((reddit.comments?.count)! > 0, "comments are ok")
    }
}
