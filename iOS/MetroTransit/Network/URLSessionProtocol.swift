//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import Foundation

typealias DataTaskResult = (NSData?, NSURLResponse?, NSError?) -> Void

protocol URLSessionProtocol {
    func dataTaskWithURL(url: NSURL, completionHandler: DataTaskResult) -> URLSessionDataTaskProtocol
}

extension NSURLSession: URLSessionProtocol {
    func dataTaskWithURL(url: NSURL, completionHandler: DataTaskResult) -> URLSessionDataTaskProtocol {
        return (dataTaskWithURL(url, completionHandler: completionHandler) as NSURLSessionDataTask) as URLSessionDataTaskProtocol
    }
}
