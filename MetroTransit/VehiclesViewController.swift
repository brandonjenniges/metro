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

    override func viewDidLoad() {
        super.viewDidLoad()
        showVehicles()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func showVehicles() {
        var annotations = [VehicleAnnotation]()
        for v in vehicles {
            let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(v.vehicleLatitude!), longitude:  CLLocationDegrees(v.vehicleLongitude!))
            let annotation = VehicleAnnotation(title: "test", locationName: "test", discipline: "test", coordinate: location)
            self.mapView.addAnnotation(annotation)
            annotations.append(annotation)
        }
        self.mapView.showAnnotations(annotations, animated: true)
    }
    
    func refreshVehicleLocations() {
        VehicleLocation.getVehicles(route, success: { (vehicles) -> Void in
            
            self.vehicles = vehicles
            var annotations = [VehicleAnnotation]()
            for v in vehicles {
                let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(v.vehicleLatitude!), longitude:  CLLocationDegrees(v.vehicleLongitude!))
                let annotation = VehicleAnnotation(title: "test", locationName: "test", discipline: "test", coordinate: location)
                self.mapView.addAnnotation(annotation)
                annotations.append(annotation)
            }
            self.mapView.showAnnotations(annotations, animated: true)
            
            }) { (routes, error) -> Void in
                
        }
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        var view: MKPinAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
        } else {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            //view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIView
        }
        return view
    }
}