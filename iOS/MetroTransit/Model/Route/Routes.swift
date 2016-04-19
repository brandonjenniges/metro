//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import Foundation
import UIKit
import ReactiveCocoa

class Routes: NSObject, UITableViewDataSource {
    
    var routes = [Route]()
    
    func updateRoutes(routes: [Route]) {
        self.routes = routes
    }
    
    // MARK: - Metro API
    
    static func get(complete complete:(routes:[Route]) -> Void) {
        let URL = NSURL(string: "http://svc.metrotransit.org/NexTrip/Routes")
        HTTPClient().get(URL!, parameters: ["format":"json"]) { (json:AnyObject?, response:NSHTTPURLResponse?, error:NSError?) -> Void in
            var routes = [Route]()
            if let json = json as? [[String : AnyObject]] {
                for item in json {
                    if let route = Route(json: item) {
                        routes.append(route)
                    }
                }
            }
            complete(routes: routes)
        }
    }
    
    static func getRoutesContainingName(string: String, routes:[Route]) -> [Route] {
        let whitespaceSet = NSCharacterSet.whitespaceCharacterSet()
        if string.stringByTrimmingCharactersInSet(whitespaceSet) == "" {
            return routes
        }
        
        let lowercaseString = string.lowercaseString
        return routes.filter { (route : Route) -> Bool in
            return route.name!.lowercaseString.rangeOfString(lowercaseString) != nil
        }
    }
    
    // MARK : - UITableView datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.routes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let route = self.routes[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = route.name!
        return cell
    }
}