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
    
    func testFullRouteStub() {
        let readyExpectation = expectationWithDescription("request")
        
        stub(isMethodGET()) { _ in
            let stubPath = OHPathForFile("full_routes.txt", self.dynamicType)
            return fixture(stubPath!, status: 200, headers: ["Content-Type":"application/json"])
        }
        
        Route.getRoutes { (routes) -> Void in
            XCTAssert(routes.count == 221)
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5.0) { (error: NSError?) -> Void in
            
        }
    }
    
    func testShortRouteStub() {
        
        let readyExpectation = expectationWithDescription("request")
        
        stub(isMethodGET()) { _ in
            let stubPath = OHPathForFile("short_routes.txt", self.dynamicType)
            return fixture(stubPath!, status: 200, headers: ["Content-Type":"application/json"])
        }
        
        Route.getRoutes { (routes) -> Void in
            XCTAssert(routes.count == 4)
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5.0) { (error: NSError?) -> Void in
            
        }
    }
    
}