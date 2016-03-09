//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

protocol VehiclesView: class {
    func addVehicleAnnotation(annotation: VehicleAnnotation)
    func showVehicleAnnotations(annotations: [VehicleAnnotation])
    func refreshVehicleAnnotations()
}