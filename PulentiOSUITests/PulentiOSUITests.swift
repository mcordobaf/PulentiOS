//
//  PulentiOSUITests.swift
//  PulentiOSUITests
//
//  Created by t on 10/12/19.
//  Copyright © 2019 mcordobaf. All rights reserved.
//

import XCTest

class PulentiOSUITests: XCTestCase {
    var app:XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testButtonSearch() {
        app.launch()
        app.buttons["btnSearch"].tap()
    }
    
    func testButtonSearchWithText(){
        app.launch()
        let textFieldSearch = app.textFields["txtSearch"]
        textFieldSearch.tap()
        textFieldSearch.typeText("Nirvana")

        app.buttons["btnSearch"].tap()
    }
    
    func testSelectSearchedTerm(){
        app.launch()
        
        let tableSongs = app.tables.matching(identifier: "tableViewSearchedTerms")
        let cell = tableSongs.cells.element(matching: .cell, identifier: "cellSearchedTerm_0")
        cell.tap()
    }
    
    func testTableSongsSearched(){
        app.launch()
        let textFieldSearch = app.textFields["txtSearch"]
        textFieldSearch.tap()
        textFieldSearch.typeText("Nirvana")

        app.buttons["btnSearch"].tap()
        
        let tableSongs = app.tables.matching(identifier: "tableViewSongs")
        let cell = tableSongs.cells.element(matching: .cell, identifier: "cellSong_0")
        cell.tap()
    }
    
    func testSelectSongAlbum(){
        app.launch()
        let textFieldSearch = app.textFields["txtSearch"]
        textFieldSearch.tap()
        textFieldSearch.typeText("Nirvana")
        
        app.buttons["btnSearch"].tap()
           
        let tableSongs = app.tables.matching(identifier: "tableViewSongs")
        let cell = tableSongs.cells.element(matching: .cell, identifier: "cellSong_0")
        cell.tap()
        
        let tableSongsAlbum = app.tables.matching(identifier: "tableViewSongsAlbum")
        let cellSongAlbum = tableSongsAlbum.cells.element(matching: .cell, identifier: "cellSongAlbum_0")
        
        cellSongAlbum.tap()
    }
    
    func testPlaySong(){
        app.launch()
        let textFieldSearch = app.textFields["txtSearch"]
        textFieldSearch.tap()
        textFieldSearch.typeText("Nirvana")
        
        app.buttons["btnSearch"].tap()
           
        let tableSongs = app.tables.matching(identifier: "tableViewSongs")
        let cell = tableSongs.cells.element(matching: .cell, identifier: "cellSong_0")
        cell.tap()
        
        let tableSongsAlbum = app.tables.matching(identifier: "tableViewSongsAlbum")
        let cellSongAlbum = tableSongsAlbum.cells.element(matching: .cell, identifier: "cellSongAlbum_0")
        cellSongAlbum.tap()
        
        app.buttons["btnPlay"].tap()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
