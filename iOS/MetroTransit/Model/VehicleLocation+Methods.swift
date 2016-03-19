//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import CoreData
import Alamofire

extension VehicleLocation {
    
    // MARK: - Core Data
    
    convenience init?(json: [String : AnyObject]) {
        let entity = VehicleLocation.getEntity(String(VehicleLocation))
        self.init(entity: entity, insertIntoManagedObjectContext: VehicleLocation.getManagedObjectContext())
        
        guard let vehicleLatitude = json["VehicleLatitude"] as? NSNumber,
            let vehicleLongitude = json["VehicleLongitude"] as? NSNumber,
            let direction = json["Direction"] as? NSNumber,
            let terminal = json["Terminal"] as? String
            else { return nil }
        
        self.vehicleLatitude = vehicleLatitude
        self.vehicleLongitude = vehicleLongitude
        self.direction = direction
        self.terminal = terminal
    }
    
    // MARK: - Metro API
    
    static func get(route: Route, complete:(vehicles:[VehicleLocation]) -> Void) {
        let URL = NSURL(string: "http://svc.metrotransit.org/NexTrip/VehicleLocations/\(route.routeNumber!)")
        HTTPClient().get(URL!, parameters: ["format": "json"]) { (json:AnyObject?, response:NSHTTPURLResponse?, error:NSError?) -> Void in
            debugPrint(response)
            var vehicles = [VehicleLocation]()
            if let json = json as? [[String : AnyObject]] {
                for item in json {
                    if let vehicle = VehicleLocation(json: item) {
                        vehicles.append(vehicle)
                    }
                }
            }
            complete(vehicles: vehicles)
        }
    }
}