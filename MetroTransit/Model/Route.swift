//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Alamofire


class Route: NSManagedObject {
    
    // MARK: - Core Data
    
    static func insert(attributes: [String : AnyObject], managedObjectContext:NSManagedObjectContext) -> Route {
        let entity = NSEntityDescription.entityForName("Route", inManagedObjectContext: managedObjectContext)
        let route = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext) as! Route
        
        if let stringValue = attributes["Route"] as? String, let intValue = Int(stringValue) {
            route.routeNumber = NSNumber(integer: intValue)
        }
        
        if let stringValue = attributes["ProviderID"] as? String, let intValue = Int(stringValue) {
            route.providerId = NSNumber(integer: intValue)
        }
        
        route.name = attributes["Description"] as? String
        return route
    }
    
    // MARK: - Metro API
    
    static func getRoutes(success onSuccess:(providers:[Route])->Void, failure onFailure:(providers:[Route], error:NSError?)->Void) {
        Alamofire.request(.GET, "http://svc.metrotransit.org/NexTrip/Routes", parameters: ["format": "json"])
            .responseJSON { response in
                debugPrint(response)
                
                var routes = [Route]()
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                if let JSON = response.result.value  as? [[String : AnyObject]] {
                    for item in JSON {
                        let route = insert(item, managedObjectContext: appDelegate.managedObjectContext)
                        routes.append(route)
                    }
                    onSuccess(providers: routes)
                } else {
                    onFailure(providers: routes, error: nil)
                }
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
}
