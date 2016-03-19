//
//  SeededAlamofire.swift
//  MetroTransit
//
//  Created by Brandon Jenniges on 3/18/16.
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import Foundation
import Alamofire

typealias DataCompletion = (NSData?, NSURLResponse?, NSError?) -> Void

class SeededURLSession: NSURLSession {
    override func dataTaskWithURL(url: NSURL, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask {
        return SeededDataTask(url: url, completion: completionHandler)
    }
}

class SeededDataTask: NSURLSessionDataTask {
    private let url: NSURL
    private let completion: DataCompletion
    private let realSession: URLSessionProtocol = NSURLSession.defaultSession()
    
    init(url: NSURL, completion: DataCompletion) {
        self.url = url
        self.completion = completion
    }
    
    override func resume() {
       // if let json = NSProcessInfo.processInfo().environment[url.absoluteString] {
        let json = "{ \"posts\" : 44 }"
            let response = NSHTTPURLResponse(URL: url, statusCode: 200, HTTPVersion: nil, headerFields: nil)
            let data = json.dataUsingEncoding(NSUTF8StringEncoding)
            completion(data, response, nil)
       // } else {
        //    print("No stubbed json found")
       // }
    }
}
