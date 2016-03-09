//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class VehiclesViewController: UIViewController, VehiclesView {
    
    @IBOutlet weak var mapView: MKMapView!
    
    static let segue = "showVehicles"
    
    let locationManager = CLLocationManager()
    var userPin: UserAnnotation?

    var presenter: VehiclesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = presenter.route.name
        presenter.showVehicles()
        setupCoreLocation()
    }
    
    // MARK: - Vehicles view

    func addVehicleAnnotation(annotation: VehicleAnnotation) {
        self.mapView.addAnnotation(annotation)
    }
    
    func showVehicleAnnotations(annotations: [VehicleAnnotation]) {
        self.mapView.showAnnotations(annotations, animated: true)
    }
    
    func refreshVehicleAnnotations() {
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
}