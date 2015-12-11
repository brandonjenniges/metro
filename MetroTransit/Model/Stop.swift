//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import Alamofire


class Stop: NSManagedObject {

    // MARK: - Core Data
    
    static func insertWithAttributes(attributes: [String : AnyObject], managedObjectContext:NSManagedObjectContext) -> Stop {
        let entity = NSEntityDescription.entityForName("Stop", inManagedObjectContext: managedObjectContext)
        let stop = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext) as! Stop
        
        if let stringValue = attributes["Value"] as? String, let intValue = Int(stringValue) {
            stop.value = NSNumber(integer: intValue)
        }
        
        stop.name = attributes["Text"] as? String
        return stop
    }
    
    // MARK: - Metro API
    
    static func getStops(direction: Direction, success onSuccess:(stops:[Stop])->Void, failure onFailure:(stops:[Stop], error:NSError?)->Void) {
        Alamofire.request(.GET, "http://svc.metrotransit.org/NexTrip/Stops/\(direction.route!.routeNumber!)/\(direction.value!)", parameters: ["format": "json"])
            .responseJSON { response in
                debugPrint(response)
                
                var stops = [Stop]()
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                if let JSON = response.result.value  as? [[String : AnyObject]] {
                    for item in JSON {
                        let stop = insertWithAttributes(item, managedObjectContext: appDelegate.managedObjectContext)
                        stops.append(stop)
                    }
                    onSuccess(stops: stops)
                } else {
                    onFailure(stops: stops, error: nil)
                }
        }
    }

}
