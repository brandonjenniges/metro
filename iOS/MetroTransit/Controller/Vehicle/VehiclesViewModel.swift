//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import Foundation
import MapKit

class VehiclesViewModel {
    
    unowned let listener: VehiclesViewModelListener
    
    let route: Route
    var vehicles: [VehicleLocation]
    
    required init(listener: VehiclesViewModelListener, route: Route, vehicles: [VehicleLocation]) {
        self.listener = listener
        self.route = route
        self.vehicles = vehicles
    }
    
    func showVehicles() {
        var annotations = [VehicleAnnotation]()
        for v in vehicles {
            let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(v.vehicleLatitude!), longitude:  CLLocationDegrees(v.vehicleLongitude!))
            let annotation = VehicleAnnotation(direction: Direction.routeDirectionForInt(Int(v.direction!)), coordinate: location)
            self.listener.addVehicleAnnotation(annotation)
            annotations.append(annotation)
        }
        self.listener.showVehicleAnnotations(annotations)
    }
    
    func refreshVehicleLocations() {
        VehicleLocation.get(route, complete: { (vehicles) -> Void in
            
            self.vehicles = vehicles
            for v in vehicles {
                let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(v.vehicleLatitude!), longitude:  CLLocationDegrees(v.vehicleLongitude!))
                let annotation = VehicleAnnotation(direction: Direction.routeDirectionForInt(Int(v.direction!)), coordinate: location)
                self.listener.addVehicleAnnotation(annotation)
            }
            self.listener.refreshVehicleAnnotations()
        })
    }
}

protocol VehiclesViewModelListener: class {
    func addVehicleAnnotation(annotation: VehicleAnnotation)
    func showVehicleAnnotations(annotations: [VehicleAnnotation])
    func refreshVehicleAnnotations()
}