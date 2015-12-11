//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class VehiclesViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var route: Route!
    var vehicles = [VehicleLocation]()
    static let segue = "showVehicles"
    let regionRadius: CLLocationDistance = 1000

    override func viewDidLoad() {
        super.viewDidLoad()
        getVehicles()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func getVehicles() {
        VehicleLocation.getVehicles(route, success: { (vehicles) -> Void in
            self.vehicles = vehicles
            
            if self.vehicles.count > 0 {
                self.setInitialLocation(self.vehicles[0])
            }
            
            for v in vehicles {
                let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(v.vehicleLatitude!), longitude:  CLLocationDegrees(v.vehicleLongitude!))
                let annotation = VehicleAnnotation(title: "test", locationName: "test", discipline: "test", coordinate: location)
                self.mapView.addAnnotation(annotation)
            }
            
            }) { (routes, error) -> Void in
                
        }
    }
    
    // MARK: - Map Helper
    
    func setInitialLocation(vehicle: VehicleLocation) {
        print(vehicle.vehicleLatitude!.doubleValue)
        print(vehicle.vehicleLongitude!.doubleValue)
        let initialLocation = CLLocation(latitude: CLLocationDegrees(vehicle.vehicleLatitude!), longitude:  CLLocationDegrees(vehicle.vehicleLongitude!))
        centerMapOnLocation(initialLocation)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        var coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? MKAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                //view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
}