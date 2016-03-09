//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import Alamofire


class VehicleLocation: NSManagedObject {
    
    // MARK: - Core Data
    
    static func insert(attributes: [String : AnyObject], managedObjectContext:NSManagedObjectContext) -> VehicleLocation {
        let entity = NSEntityDescription.entityForName("VehicleLocation", inManagedObjectContext: managedObjectContext)
        let vehicle = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext) as! VehicleLocation
        
        vehicle.vehicleLatitude = attributes["VehicleLatitude"] as? NSNumber
        vehicle.vehicleLongitude = attributes["VehicleLongitude"] as? NSNumber
        vehicle.direction = attributes["Direction"] as? NSNumber
        vehicle.terminal = attributes["Terminal"] as? String
        return vehicle
    }
    
    // MARK: - Metro API
    
    static func getVehicles(route: Route, success onSuccess:(vehicles:[VehicleLocation])->Void, failure onFailure:(vehicles:[VehicleLocation], error:NSError?)->Void) {
        Alamofire.request(.GET, "http://svc.metrotransit.org/NexTrip/VehicleLocations/\(route.routeNumber!)", parameters: ["format": "json"])
            .responseJSON { response in
                debugPrint(response)
                var vehicles = [VehicleLocation]()
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                if let JSON = response.result.value  as? [[String : AnyObject]] {
                    for item in JSON {
                        let vehicle = insert(item, managedObjectContext: appDelegate.managedObjectContext)
                        vehicles.append(vehicle)
                    }
                    onSuccess(vehicles: vehicles)
                } else {
                    onFailure(vehicles: vehicles, error: nil)
                }
        }
    }
    
}