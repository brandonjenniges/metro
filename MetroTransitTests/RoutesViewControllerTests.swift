//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import XCTest
@testable import MetroTransit

class RoutesViewControllerTests: XCTestCase {
    
    var viewController: RoutesViewController!
    
    override func setUp() {
        viewController = RoutesViewController.getViewController()
    }
    
    override func tearDown() {
        
    }
    
    func testInit() {
        XCTAssertNotNil(viewController, "Unable to create RoutesViewController")
    }
}