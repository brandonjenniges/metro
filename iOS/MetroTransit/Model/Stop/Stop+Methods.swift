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
        let URL = NSURL(string: "http://svc.metrotransit.org/NexTrip/Stops/\(direction.route!.routeNumber!)/\(direction.value!)")
        HTTPClient().get(URL!, parameters: ["format": "json"]) { (json:AnyObject?, response:NSHTTPURLResponse?, error:NSError?) -> Void in
            debugPrint(response)
            
            var stops = [Stop]()
            if let json = json as? [[String : AnyObject]] {
                for item in json {
                    if let stop = Stop(json: item) {
                        stops.append(stop)
                    }
                }
            }
            complete(stops: stops)
        }
    }
}