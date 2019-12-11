//
//  PulentiOSTests.swift
//  PulentiOSTests
//
//  Created by t on 10/12/19.
//  Copyright © 2019 mcordobaf. All rights reserved.
//

import XCTest
@testable import PulentiOS

class PulentiOSTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testExampleData() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expectation = XCTestExpectation(description: "Response requests")
        let itunesDAO = ItunesDAO.getInstance()
        
        let listener: RequestListener = {
            class ListenerAnonymous : RequestListener {
                var expectation:XCTestExpectation!
                
                let itunesDAO = ItunesDAO.getInstance()
                
                init(expectation:XCTestExpectation){
                    self.expectation = expectation

                }
                
                func respond(data: Data?) {
                    itunesDAO.searchSongsByAlbum(collectionId: 1440657497 , listener: self)
                    itunesDAO.downloadPreviewSong(url: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview128/v4/5b/d8/38/5bd8385b-90fe-1609-54af-ccc530ad8304/mzaf_6356427096874789739.plus.aac.p.m4a", listener: self)
                }
                
                func error(error: Error) {
                    
                }
                
                
            }
            return ListenerAnonymous(expectation: expectation)
        }()
        
        itunesDAO.searchByTerm(term: "In utero", pagination: 20, listener: listener)
        
        
    }
    
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
