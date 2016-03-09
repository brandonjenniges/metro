//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import MapKit

class VehicleAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(direction: Direction.RouteDirection, coordinate: CLLocationCoordinate2D) {
        self.title = Direction.stringForDirection(direction)
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return nil
    }
}
