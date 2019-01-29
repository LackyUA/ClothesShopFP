//
//  ShopAppUITests.swift
//  ShopAppUITests
//
//  Created by Dmytro Dobrovolskyy on 1/29/19.
//  Copyright © 2019 YellowLeaf. All rights reserved.
//

import XCTest

class ShopAppUITests: XCTestCase {
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testStroreView() {
        let app = XCUIApplication()
        
        app.tabBars.buttons.element(boundBy: 0).tap()
        
        let collectionView = app.collectionViews["collectionView--shopCollectionView"]
        
        if collectionView.cells.count > 0 {
            for index in 0...3 {
                let cell = collectionView.cells.element(boundBy: index)
                
                cell.tap()
                app.swipeLeft()
                app.swipeRight()
                
                // Add item to cart
                app.buttons["button--shopDetailsCartButton"].tap()
                app.alerts.buttons.element.tap()
                
                // Back
                app.buttons["button--shopDetailsBackButton"].tap()
            }
            XCTAssertTrue(true, "Finished validating the collection cells")
        } else {
            XCTAssertTrue(false, "Was not able to find any collection cells")
        }
        
        app.tabBars.buttons.element(boundBy: 1).tap()
        testCartView()
    }

    func testCartView() {
        let app = XCUIApplication()
        
        app.swipeUp()
        app.swipeUp()
        app.swipeDown()
        app.swipeUp()
    }
//    func testStoreFunctionality() {
//
//        // Assert collection view displaying
//        let shopCollectionView = app.collectionViews["collectionView--shopCollectionView"]
//        XCTAssertTrue(shopCollectionView.exists, "Shop collection view exists.")
//
//        // Get an array of cells
//        let shopCollectionCells = shopCollectionView.cells
//
//        if shopCollectionCells.count > 0 {
//            let promise = expectation(description: "Wait for collection cells")
//
//            for index in 0...shopCollectionCells.count - 1 {
//                // Check if cell exists
//                let shopCollectionViewCell = shopCollectionCells.element(boundBy: index)
//                XCTAssertTrue(shopCollectionViewCell.exists, "The \(index) cell is placed on the collection")
//
//                // Tap on cell
//                shopCollectionViewCell.tap()
//                if index == shopCollectionCells.count {
//                    promise.fulfill()
//                }
//
//                app.swipeLeft()
//                app.swipeRight()
//
//                // Back
//                app.buttons["button--shopDetailsBackButton"].tap()
//            }
//
//            waitForExpectations(timeout: 10, handler: nil)
//            XCTAssertTrue(true, "Finished validating the collection cells")
//        } else {
//            XCTAssert(false, "Was not able to find any collection cells")
//        }
//    }

}
