//
//  GH_StargazersUITests.swift
//  GH StargazersUITests
//
//  Created by Emanuel Carnevale on 11/10/2020.
//

import XCTest

class GH_StargazersUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        let ownerNameTextField = elementsQuery.textFields["Owner name"]
        ownerNameTextField.tap()
        app.keys["octocat"]
        
        
        
        // Use recording to get started writing UI tests.
        


//        ownerNameTextField.tap()
//
//        let repositoryNameTextField = elementsQuery.textFields["Repository name"]
//        repositoryNameTextField.tap()
//
//        let stargazerElement = scrollViewsQuery.otherElements.containing(.image, identifier:"Stargazer").element
//        stargazerElement.tap()
//        repositoryNameTextField.tap()
//        ownerNameTextField.tap()
//
//        let checkStargazersStaticText = elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["Check Stargazers"]/*[[".buttons[\"Check Stargazers\"].staticTexts[\"Check Stargazers\"]",".staticTexts[\"Check Stargazers\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        checkStargazersStaticText.tap()
//        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Willianvdv"].swipeRight()/*[[".cells.staticTexts[\"Willianvdv\"]",".swipeUp()",".swipeRight()",".staticTexts[\"Willianvdv\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
//        app.navigationBars["octocat/hello-world"].buttons["GH Stargazers"].tap()
//        repositoryNameTextField.tap()
//        checkStargazersStaticText.tap()
//        app.alerts["Error"].scrollViews.otherElements.buttons["Ok"].tap()
//        repositoryNameTextField.tap()
//        stargazerElement.tap()
//        stargazerElement.tap()
//        stargazerElement.tap()
//        ownerNameTextField.tap()
//        ownerNameTextField.tap()
//        repositoryNameTextField.tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
//
//        let scrollViewsQuery = app.scrollViews
//        let elementsQuery = scrollViewsQuery.otherElements
//        elementsQuery.textFields["Owner name"].tap()
//
//        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        oKey.tap()
//        oKey.tap()
//
//        let cKey = app/*@START_MENU_TOKEN@*/.keys["c"]/*[[".keyboards.keys[\"c\"]",".keys[\"c\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        cKey.tap()
//        cKey.tap()
//
//        let tKey = app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        tKey.tap()
//        tKey.tap()
//        oKey.tap()
//        oKey.tap()
//        cKey.tap()
//        cKey.tap()
//
//        let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        aKey.tap()
//        aKey.tap()
//        tKey.tap()
//        tKey.tap()
//        scrollViewsQuery.otherElements.containing(.image, identifier:"Stargazer").element.tap()
//        elementsQuery.textFields["Repository name"].tap()
//        aKey.tap()
//        aKey.tap()
//        app.scrollViews.containing(.other, identifier:"Vertical scroll bar, 1 page").element.tap()
//
    }

}
