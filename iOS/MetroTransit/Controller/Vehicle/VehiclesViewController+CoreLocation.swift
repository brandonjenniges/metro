//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import CoreLocation

extension VehiclesViewController: CLLocationManagerDelegate {
    
    func setupCoreLocation() {
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    // MARK : - CLLocationManager delegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        if let userPin = self.userPin {
            userPin.coordinate = coordinate
        } else {
            self.userPin = UserAnnotation(title: "You", coordinate: coordinate)
            mapView.addAnnotation(self.userPin!)
            mapView.showAnnotations(mapView.annotations, animated: true)
        }
    }
}