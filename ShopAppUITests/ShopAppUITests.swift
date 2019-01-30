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
        
        // Open store view
        app.tabBars.buttons.element(boundBy: 0).tap()
        
        let collectionView = app.collectionViews["collectionView--shopCollectionView"]
        if collectionView.cells.count > 0 {
            for index in 0...2 {
                let cell = collectionView.cells.element(boundBy: index)
                
                cell.tap()
                
                testDetailsView()
            }
            XCTAssertTrue(true, "Finished validating the collection cells")
        } else {
            XCTAssertTrue(false, "Was not able to find any collection cells")
        }
        
        testCartView()
    }
    
    func testDetailsView() {
        let app = XCUIApplication()
        
        // Swipe images
        app.swipeLeft()
        app.swipeRight()
        
        // Add item to cart
        app.buttons["button--shopDetailsCartButton"].tap()
        app.alerts.buttons.element.tap()
        
        // Back
        app.buttons["button--shopDetailsBackButton"].tap()
    }

    func testCartView() {
        let app = XCUIApplication()
        
        // Open cart view
        app.tabBars.buttons.element(boundBy: 1).tap()
        
        // Swipe items
        app.swipeUp()
        app.swipeDown()
        app.swipeUp()
        app.swipeDown()
        
        // Detele items
        let tableView = app.tables["table--cartTableView"]
        
        if tableView.cells.count > 0 {
            let cell = tableView.cells.element(boundBy: 0)
            cell.buttons["button--cartDeleteItemButton"].tap()
        }
        
        // Swipe items
        app.swipeUp()
        app.swipeDown()
        app.swipeUp()
        app.swipeDown()
    }
    
    func testRegistration() {
        let app = XCUIApplication()
        
        // Test e-mail text field
        app.textFields["E-mail"].tap()
        
        for letter in "joker" {
            app.keys[String(describing: letter)].tap()
        }
        
        app.keys["more"].tap()
        app.keys["@"].tap()
        
        app.keys["more"].tap()
        for letter in "lol" {
            app.keys[String(describing: letter)].tap()
        }
        
        app.keys["more"].tap()
        app.keys["."].tap()
        
        app.keys["more"].tap()
        for letter in "com" {
            app.keys[String(describing: letter)].tap()
        }
        
        // Test password field
        app.textFields["Password"].tap()
        for letter in "jokerlol" {
            app.keys[String(describing: letter)].tap()
        }
        
        // Log in button test
        app.buttons["Log in"].tap()
        
        sleep(3)
        testStroreView()
        
        // Open store view
        app.tabBars.buttons.element(boundBy: 0).tap()
        
        // Back to log in view
        app.navigationBars.buttons["Sign Out"].tap()
    }
    
}
