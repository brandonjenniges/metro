//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import XCTest

extension XCTestCase {
    func waitForElementToAppear(element: XCUIElement, file: String = __FILE__, line: UInt = __LINE__) {
        let existsPredicate = NSPredicate(format: "exists == true")
        expectationForPredicate(existsPredicate, evaluatedWithObject: element, handler: nil)
        
        waitForExpectationsWithTimeout(5) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after 5 seconds."
                self.recordFailureWithDescription(message, inFile: file, atLine: line, expected: true)
            }
        }
    }
}
