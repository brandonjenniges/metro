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
        Alamofire.request(.GET, "http://svc.metrotransit.org/NexTrip/VehicleLocations/\(route.routeNumber!)", parameters: ["format": "json"])
            .responseJSON { response in
                debugPrint(response)
                var vehicles = [VehicleLocation]()
                if let JSON = response.result.value  as? [[String : AnyObject]] {
                    for item in JSON {
                        if let vehicle = VehicleLocation(json: item) {
                            vehicles.append(vehicle)
                        }
                    }
                }
                complete(vehicles: vehicles)
        }
    }
    
}