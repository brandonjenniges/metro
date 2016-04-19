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
    
}
