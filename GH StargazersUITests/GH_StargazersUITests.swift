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
    
    func fillTextfield(in app: XCUIApplication, named textFieldName: String, with textFieldContent: String) {
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        let textField = elementsQuery.textFields[textFieldName]
        textField.tap()
        textField.typeText(textFieldContent)
    }

    func testButtonEnabled() throws {
        let expectation = self.expectation(description: "Check Stargazers button should be enabled only when both owner and repo field are filled in")
        let app = XCUIApplication()
        app.launch()
        
        fillTextfield(in: app, named: "Owner name", with: "octocat")
        
        let button = app.scrollViews.otherElements.buttons["Check Stargazers"]
        XCTAssertFalse(button.isEnabled)
        
        fillTextfield(in: app, named: "Repository name", with: "hello-world")
        
        XCTAssertTrue(button.isEnabled)

        expectation.fulfill()
    }
    
    func testLoadRequest() throws {
        let expectation = self.expectation(description: "Check Stargazers button should be enabled only when both owner and repo field are filled in")
        let app = XCUIApplication()
        app.launch()
        
        fillTextfield(in: app, named: "Owner name", with: "octocat")
        fillTextfield(in: app, named: "Repository name", with: "hello-worl")
        
        let button = app.scrollViews.otherElements.buttons["Check Stargazers"]
        XCTAssertTrue(button.isEnabled)
        
        button.tap()
        
        let navigationBar = app.navigationBars["octocat/hello-world"]
        XCTAssertTrue(navigationBar.exists)
//        
//        let app = XCUIApplication()
//        let elementsQuery2 = app.scrollViews.otherElements
//        let checkStargazersStaticText = elementsQuery2/*@START_MENU_TOKEN@*/.staticTexts["Check Stargazers"]/*[[".buttons[\"Check Stargazers\"].staticTexts[\"Check Stargazers\"]",".staticTexts[\"Check Stargazers\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        checkStargazersStaticText.tap()
//        
//        let octocatHelloWorldNavigationBar = app.navigationBars["octocat/hello-world"]
//        let octocatHelloWorldStaticText = octocatHelloWorldNavigationBar.staticTexts["octocat/hello-world"]
//        octocatHelloWorldStaticText.tap()
//        octocatHelloWorldStaticText.tap()
//        
//        let ghStargazersButton = octocatHelloWorldNavigationBar.buttons["GH Stargazers"]
//        ghStargazersButton.tap()
//        checkStargazersStaticText.tap()
//        ghStargazersButton.tap()
//        
//        let repositoryNameTextField = elementsQuery2.textFields["Repository name"]
//        repositoryNameTextField.tap()
//        repositoryNameTextField.tap()
//        checkStargazersStaticText.tap()
//        
//        let elementsQuery = app.alerts["Error"].scrollViews.otherElements
//        elementsQuery.staticTexts["Not Found"].tap()
//        elementsQuery.buttons["Ok"].tap()
//        repositoryNameTextField.tap()
//        checkStargazersStaticText.tap()
//        app.tables/*@START_MENU_TOKEN@*/.staticTexts["preavy"].swipeRight()/*[[".cells.staticTexts[\"preavy\"]",".swipeUp()",".swipeRight()",".staticTexts[\"preavy\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
//        ghStargazersButton.tap()
//                

//        expectation.fulfill()
    }

}
