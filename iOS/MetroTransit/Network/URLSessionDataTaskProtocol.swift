//
//  URLSessionDataTaskProtocol.swift
//  MetroTransit
//
//  Created by Brandon Jenniges on 3/18/16.
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension NSURLSessionDataTask: URLSessionDataTaskProtocol { }
