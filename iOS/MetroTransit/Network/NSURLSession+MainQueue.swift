//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import Foundation

extension NSURLSession {
    static func defaultSession() -> NSURLSession {
        return NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
    }
}