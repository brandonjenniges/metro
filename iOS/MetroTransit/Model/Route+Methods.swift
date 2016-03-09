//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit
import CoreData
import Alamofire


extension Route {
    
    // MARK: - Core Data
    
    convenience init?(json: [String : AnyObject]) {
        let entity = Route.getEntity(String(Route))
        self.init(entity: entity, insertIntoManagedObjectContext: Route.getManagedObjectContext())
        
        guard let routeNumberString = json["Route"] as? String,
            let routeNumberInt = Int(routeNumberString),
            let providerIdString = json["ProviderID"] as? String,
            let providerIdInt = Int(providerIdString),
            let routeName = json["Description"] as? String
        else { return nil }
        
        self.routeNumber = NSNumber(integer: routeNumberInt)
        self.providerId = NSNumber(integer: providerIdInt)
        self.name = routeName
    }
    
    // MARK: - Metro API
    
    static func getRoutes(complete complete:(routes:[Route]) -> Void) {
        Alamofire.request(.GET, "http://svc.metrotransit.org/NexTrip/Routes", parameters: ["format": "json"])
            .responseJSON { response in
                debugPrint(response)
                
                var routes = [Route]()
                if let JSON = response.result.value  as? [[String : AnyObject]] {
                    for item in JSON {
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
}
