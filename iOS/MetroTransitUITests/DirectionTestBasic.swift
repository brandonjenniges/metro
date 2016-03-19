//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import XCTest

class DirectionTestBasic: XCTestCase {
    
    let app = XCUIApplication()
    let routeResponse = "[{\"Description\":\"METRO Blue Line\",\"ProviderID\":\"8\",\"Route\":\"901\"},{\"Description\":\"METRO Red Line\",\"ProviderID\":\"9\",\"Route\":\"903\"}]"
    let directionResponse = "[{\"Text\":\"NORTHBOUND\",\"Value\":\"4\"},{\"Text\":\"SOUTHBOUND\",\"Value\":\"1\"}]"
    
    let routeNumber = 901
    let routeName = "METRO Blue Line"
    let directionName = "NORTHBOUND"
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        app.launchArguments += ["UI-TESTING"]
        app.launchEnvironment["http://svc.metrotransit.org/NexTrip/Routes"] = routeResponse
        app.launchEnvironment["http://svc.metrotransit.org/NexTrip/Directions/\(routeNumber)"] = directionResponse
        app.launch()
    }
    
    func test_OpenDirections() {
        let postCountLabel = app.staticTexts[routeName]
        waitForElementToAppear(postCountLabel)
        app.tables.staticTexts[routeName].tap()
        app.sheets[routeName].collectionViews.buttons["Directions"].tap()
        let dLabel = app.staticTexts[directionName]
        waitForElementToAppear(dLabel)
    }
}