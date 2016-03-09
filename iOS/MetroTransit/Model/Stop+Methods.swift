//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit
import CoreData
import Alamofire


extension Stop {
    
    // MARK: - Core Data
    
    convenience init?(json: [String : AnyObject]) {
        let entity = Stop.getEntity(String(Stop))
        self.init(entity: entity, insertIntoManagedObjectContext: Stop.getManagedObjectContext())
        
        guard let value = json["Value"] as? String,
            let name = json["Text"] as? String
        else { return nil }
        
        self.value = value
        self.name = name
    }
    
    // MARK: - Metro API
    
    static func get(direction: Direction, complete:(stops:[Stop]) -> Void) {
        Alamofire.request(.GET, "http://svc.metrotransit.org/NexTrip/Stops/\(direction.route!.routeNumber!)/\(direction.value!)", parameters: ["format": "json"])
            .responseJSON { response in
                debugPrint(response)
                
                var stops = [Stop]()
                if let JSON = response.result.value  as? [[String : AnyObject]] {
                    for item in JSON {
                        if let stop = Stop(json: item) {
                            stops.append(stop)
                        }
                    }
                }
                complete(stops: stops)
        }
    }
    
}
