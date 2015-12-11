//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import Foundation
import CoreData

extension VehicleLocation {

    @NSManaged var bearing: NSNumber?
    @NSManaged var blockNumber: NSNumber?
    @NSManaged var direction: NSNumber?
    @NSManaged var locationTime: NSDate?
    @NSManaged var odometer: NSNumber?
    @NSManaged var route: String?
    @NSManaged var speed: NSNumber?
    @NSManaged var terminal: String?
    @NSManaged var vehicleLatitude: NSNumber?
    @NSManaged var vehicleLongitude: NSNumber?

}
