//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import MapKit

class UserAnnotation: NSObject, MKAnnotation  {

    let title: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        super.init()
    }
    
    var subtitle: String? {
        return "Me"
    }
}
