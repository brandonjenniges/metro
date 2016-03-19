//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import XCTest

class RouteTestBasic: XCTestCase {
    
    let app = XCUIApplication()
    let routeResponse = "[{\"Description\":\"METRO Blue Line\",\"ProviderID\":\"8\",\"Route\":\"901\"},{\"Description\":\"METRO Red Line\",\"ProviderID\":\"9\",\"Route\":\"903\"}]"
    
    let routeName = "METRO Blue Line"
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        app.launchArguments += ["UI-TESTING"]
        app.launchEnvironment["http://svc.metrotransit.org/NexTrip/Routes"] = routeResponse
        app.launch()
    }
    
    func test_DisplayRoutes() {
        let postCountLabel = app.staticTexts["METRO Blue Line"]
        waitForElementToAppear(postCountLabel)
    }
}