//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class VehiclesPresenter {
    unowned let view: VehiclesView
    
    let route: Route
    var vehicles: [VehicleLocation]
    
    required init(view: VehiclesView, route: Route, vehicles: [VehicleLocation]) {
        self.view = view
        self.route = route
        self.vehicles = vehicles
    }
    
    func showVehicles() {
        var annotations = [VehicleAnnotation]()
        for v in vehicles {
            let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(v.vehicleLatitude!), longitude:  CLLocationDegrees(v.vehicleLongitude!))
            let annotation = VehicleAnnotation(direction: Direction.routeDirectionForInt(Int(v.direction!)), coordinate: location)
            self.view.addVehicleAnnotation(annotation)
            annotations.append(annotation)
        }
        self.view.showVehicleAnnotations(annotations)
    }
    
    func refreshVehicleLocations() {
        VehicleLocation.get(route, complete: { (vehicles) -> Void in
            
            self.vehicles = vehicles
            for v in vehicles {
                let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(v.vehicleLatitude!), longitude:  CLLocationDegrees(v.vehicleLongitude!))
                let annotation = VehicleAnnotation(direction: Direction.routeDirectionForInt(Int(v.direction!)), coordinate: location)
                self.view.addVehicleAnnotation(annotation)
            }
            self.view.refreshVehicleAnnotations()
        })
    }
}