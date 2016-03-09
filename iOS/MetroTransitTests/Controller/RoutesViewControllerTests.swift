//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import XCTest
import OHHTTPStubs

@testable import MetroTransit

class RoutesViewControllerTests: XCTestCase {
    
    var viewController: RoutesViewController!
    var presenter: RoutesPresenter!
    
    override func setUp() {
        //viewController = RoutesViewController.getViewController()
        //presenter = RoutesPresenter(view: viewController)
        //viewController.presenter = presenter
    }
    
    override func tearDown() {
        
    }
    
    func testInit() {
       // XCTAssertNotNil(viewController, "Unable to create RoutesViewController")
    }
    
    func testStub() {
        let readyExpectation = expectationWithDescription("request")
        
        stub(isMethodGET()) { _ in
            let stubPath = OHPathForFile("routes.txt", self.dynamicType)
            return fixture(stubPath!, status: 200, headers: ["Content-Type":"application/json"])
        }
        
        Route.getRoutes { (routes) -> Void in
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5.0) { (error: NSError?) -> Void in
            
        }
    }
}