//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import Foundation
import Alamofire

typealias HTTPResult = (AnyObject?, NSHTTPURLResponse?, NSError?) -> Void

class HTTPClient {
    private let useTestConfig: Bool
    
    init(useTestConfig: Bool = NetworkConfig.useTestConfig) {
        self.useTestConfig = useTestConfig
    }
    
    func get(url: NSURL, completion: HTTPResult) {
        get(url, parameters: nil, completion: completion)
    }
    
    func get(url: NSURL, parameters: [ String: AnyObject]?, completion: HTTPResult) {
        if useTestConfig {
            if let json = NSProcessInfo.processInfo().environment[url.absoluteString] {
                let response = NSHTTPURLResponse(URL: url, statusCode: 200, HTTPVersion: nil, headerFields: nil)
                let data = json.dataUsingEncoding(NSUTF8StringEncoding)
                completion(parse(data), response, nil)
            } else {
                print("Unable to find json")
            }
        } else {
            Alamofire.request(.GET, url.absoluteString, parameters: parameters)
                .response(completionHandler: { (request: NSURLRequest?, response: NSHTTPURLResponse?, data: NSData?, error: NSError?) -> Void in
                    completion(self.parse(data), response, error)
                })
            
        }
    }
    
    func parse(data: NSData?) -> AnyObject? {
        guard let
            data = data,
            json = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
            else { return nil }
        return json
    }
}